<template>
    <div>
        <p>solve me if you can!</p>

        <!------------------------------------------------------------------------------- modal trigger -->

        <!-- open modal: click button to call openModal() -->
        <div style="width: 304px; height: 78px" @click="openModal" ref="container">
            <div id="rc-anchor-alert" class="rc-anchor-alert"></div>
            <div id="rc-anchor-container" class="rc-anchor rc-anchor-normal rc-anchor-light" style="position: relative">
                <div id="recaptcha-accessible-status" class="rc-anchor-aria-status" aria-hidden="true">Please verify yourself.</div>
                <div class="rc-anchor-error-msg-container" style="display: none">
                    <span class="rc-anchor-error-msg" aria-hidden="true"></span>
                </div>
                <div class="rc-anchor-content">
                    <!-- loading spinner-->
                    <div class="rc-inline-block">
                        <div class="rc-anchor-center-container">
                            <div class="rc-anchor-center-item rc-anchor-checkbox-holder">
                                <span class="recaptcha-checkbox goog-inline-block recaptcha-checkbox-unchecked rc-anchor-checkbox" role="checkbox" aria-checked="false" id="recaptcha-anchor" dir="ltr" aria-labelledby="recaptcha-anchor-label" aria-disabled="false" tabindex="0">
                                    <div class="recaptcha-checkbox-border" role="presentation" v-show="!IS_LOADING_MODAL"></div>
                                    <div class="recaptcha-checkbox-borderAnimation" role="presentation" :style="IS_LOADING_MODAL ? { 'background-position': '-28px -588px' } : {}"></div>
                                    <div class="recaptcha-checkbox-spinner" role="presentation" v-show="IS_LOADING_MODAL" :style="{ 'animation-play-state': 'running', opacity: IS_LOADING_MODAL ? 1 : 0, transform: 'scale(0)' }">
                                        <div class="recaptcha-checkbox-spinner-overlay" style="animation-play-state: running"></div>
                                    </div>
                                    <div class="recaptcha-checkbox-checkmark" role="presentation"></div>
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- 'i'm not a robot' title -->
                    <div class="rc-inline-block">
                        <div class="rc-anchor-center-container">
                            <label class="rc-anchor-center-item rc-anchor-checkbox-label" aria-hidden="true" role="presentation" id="recaptcha-anchor-label">
                                <span aria-live="polite" aria-labelledby="recaptcha-accessible-status"></span>
                                I'm not a robot
                            </label>
                        </div>
                    </div>
                </div>

                <!-- recaptcha logo -->
                <div class="rc-anchor-normal-footer">
                    <div class="rc-anchor-logo-portrait" aria-hidden="true" role="presentation">
                        <div class="rc-anchor-logo-img rc-anchor-logo-img-portrait"></div>
                        <div class="rc-anchor-logo-text">reCAPTCHA</div>
                    </div>
                    <div class="rc-anchor-pt">
                        <a href="https://policies.google.com/privacy?hl=en" target="_blank">Privacy</a>
                        <span aria-hidden="true" role="presentation"> - </span>
                        <a href="https://policies.google.com/terms?hl=en/" target="_blank">Terms</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- close modal: transparent layer behind the modal that serves as a close button -->
        <div @click="SHOW_MODAL = false" style="width: 100%; height: 100%; position: fixed; top: 0px; left: 0px; z-index: 2000000000; background-color: rgb(255, 255, 255); opacity: 0" v-show="SHOW_MODAL"></div>

        <!------------------------------------------------------------------------------- modal -->

        <div :style="MODAL_STYLE">
            <div v-show="el_arrow" class="g-recaptcha-bubble-arrow" style="border-width: 11px; border-style: solid; border-color: transparent rgb(204, 204, 204) transparent transparent; border-image: initial; width: 0px; height: 0px; position: absolute; pointer-events: none; margin-top: -11px; z-index: 2000000000; top: 35px; right: 100%"></div>
            <div v-show="el_arrow" class="g-recaptcha-bubble-arrow" style="border-width: 10px; border-style: solid; border-color: transparent rgb(255, 255, 255) transparent transparent; border-image: initial; width: 0px; height: 0px; position: absolute; pointer-events: none; margin-top: -10px; z-index: 2000000000; top: 35px; right: 100%"></div>

            <div id="rc-imageselect">
                <div id="rc-imageselect">
                    <div class="rc-imageselect-response-field"></div>
                    <span class="rc-imageselect-tabloop-begin" tabindex="0"></span>
                    <div class="rc-imageselect-payload">
                        <div class="rc-imageselect-instructions" style="margin-bottom: 7px" ref="instructions">
                            <div class="rc-imageselect-desc-wrapper">
                                <!-- instruction -->
                                <div class="rc-imageselect-desc-no-canonical" style="font-size: 12px">
                                    Select all squares with<strong style="font-size: 28px">{{ SEARCH_QUERY }}</strong> If there are none, click verify
                                </div>
                            </div>
                            <div class="rc-imageselect-progress"></div>
                        </div>

                        <!-- image selection -->
                        <div class="rc-imageselect-challenge">
                            <div id="rc-imageselect-target" class="rc-imageselect-target" dir="ltr" role="presentation" aria-hidden="true">
                                <table class="rc-imageselect-table-33">
                                    <tbody>
                                        <tr v-for="tr in 3" :key="tr">
                                            <td role="button" tabindex="0" class="rc-imageselect-tile" :class="{ 'rc-imageselect-tileselected': list_selected.includes(tr + '_' + td) }" aria-label="image verification" v-for="td in 3" :key="td" @click="_select(tr + '_' + td)">
                                                <div class="rc-image-tile-target">
                                                    <div class="rc-image-tile-wrapper" :style="{ width: wrapper_size + 'px', height: wrapper_size + 'px' }">
                                                        <img class="rc-image-tile-33" :src="require('./assets/payload/' + payload_filename)" :style="{ top: '-' + (tr - 1) * 100 + '%', left: '-' + (td - 1) * 100 + '%' }" />
                                                        <div class="rc-image-tile-overlay"></div>
                                                    </div>
                                                    <div class="rc-imageselect-checkbox"></div>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- error messages -->
                        <div class="rc-imageselect-incorrect-response" v-show="is_wrong_input == 'rc-imageselect-incorrect-response'">Please try again.</div>
                        <div class="rc-imageselect-error-select-more" v-show="is_wrong_input == 'rc-imageselect-error-select-more'">Please select all images that apply.</div>
                    </div>

                    <div class="rc-footer">
                        <div class="rc-separator"></div>
                        <div class="rc-controls">
                            <div class="primary-controls">
                                <!-- reload button -->
                                <div class="rc-buttons">
                                    <div class="button-holder reload-button-holder">
                                        <button class="rc-button goog-inline-block rc-button-reload" title="Change your verification code" value="" id="recaptcha-reload-button" tabindex="0" @click="_delay_reload"></button>
                                    </div>
                                    <div class="button-holder help-button-holder">
                                        <a href="https://support.google.com/recaptcha/?hl=en" target="_blank" rel="noopener noreferrer" class="rc-button goog-inline-block rc-button-help" title="help" value="" id="recaptcha-help-button" tabindex="0"></a>
                                    </div>
                                </div>

                                <!-- submission button -->
                                <div class="verify-button-holder">
                                    <button class="rc-button-default goog-inline-block" title="" value="" id="recaptcha-verify-button" :class="{ 'rc-button-default-disabled': el_rel_loading }" tabindex="0" @click="_verify">verify</button>
                                </div>
                            </div>

                            <div class="rc-challenge-help" style="display: none" tabindex="0"></div>
                        </div>
                    </div>
                    <span class="rc-imageselect-tabloop-end" tabindex="0"></span>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import "typeface-roboto";
import delay from "delay";

// todo: until nothing is selected the button says "skip" instead of "verify"

const images = require
    .context("./assets/payload", true, /^.*\.png$/)
    .keys()
    .map((x) => x.replace("./", ""));
const getRandomImage = () => images[Math.floor(Math.random() * images.length)];

const searchQueries = ["bus", "fire hydrant", "chimney", "mountain", "plane", "crosswalk", "bridge", "bicycle"];
const getRandomSearchQuery = () => searchQueries[Math.floor(Math.random() * searchQueries.length)];

export default {
    // initial state of component
    data() {
        return {
            SHOW_MODAL: false,
            IS_LOADING_MODAL: false,
            SEARCH_QUERY: getRandomSearchQuery(),

            el_rel_loading: false,
            el_arrow: false,

            MODAL_STYLE: { "background-color": "rgb(255, 255, 255)", border: "1px solid rgb(204, 204, 204)", "box-shadow": " rgb(0 0 0 / 20%) 2px 2px 3px", position: "absolute", transition: "visibility 0s linear 0s, opacity 0.3s linear 0s", opacity: "1", "z-index": "2000000000", visibility: "hidden" },
            list_selected: [],

            wrapper_size: 126,

            is_wrong_input: "",

            payload_filename: getRandomImage(),
        };
    },

    mounted() {
        window.addEventListener("resize", () => {
            if (this.SHOW_MODAL) {
                this._fix_position();
            }
        });
    },

    methods: {
        async openModal() {
            this.IS_LOADING_MODAL = true;
            await this._reload();
            await delay(300);
            this.SHOW_MODAL = true;
            await delay(300);
            this.IS_LOADING_MODAL = false;
        },

        async _reload() {
            let _id = this.payload_filename;
            let _name = this.SEARCH_QUERY;
            while (_id == this.payload_filename) {
                this.payload_filename = getRandomImage();
            }
            while (_name == this.SEARCH_QUERY) {
                this.SEARCH_QUERY = getRandomSearchQuery();
            }
        },

        async _delay_reload() {
            this.list_selected = [];
            this.el_rel_loading = true;
            await delay(800);
            await this._reload();
            this.el_rel_loading = false;
        },

        async _show_error(n) {
            this.is_wrong_input = n;
            await delay(1000);
            this.is_wrong_input = null;
        },

        async _verify() {
            if (this.list_selected.length < 2) {
                return this._show_error("rc-imageselect-error-select-more");
            }
            this.el_rel_loading = true;
            await delay(1000);
            await this._show_error("rc-imageselect-incorrect-response");
            await this._delay_reload();
        },

        async _select(key) {
            if (this.el_rel_loading) return;
            if (this.list_selected.includes(key)) return (this.list_selected = this.list_selected.filter((x) => x != key));
            this.list_selected.push(key);
        },

        async _fix_position() {
            const _bounding = this.$refs.container.getBoundingClientRect();
            const _style = this.MODAL_STYLE;
            const _m = window.innerWidth < 470;
            this.el_arrow = !_m;
            if (_m) {
                const _width = window.innerWidth;
                _style.width = _width - 5 + "px";
                this.wrapper_size = Math.floor((_width - 5) / 3) - 7.55555;
                _style.left = 0;
                _style.right = 0;
                _style.margin = "auto";
            } else {
                _style.width = "408px";
                this.wrapper_size = 128.5;
                _style.left = _m ? 0 : _bounding.left + 51 + "px";
                _style.top = _bounding.top + 2 + "px";
                delete _style.margin;
            }
        },
    },

    watch: {
        SHOW_MODAL(value) {
            this._fix_position();
            const _style = this.MODAL_STYLE;
            _style.visibility = value ? "visible" : "hidden";
            _style.opacity = value ? "1" : "0";
            _style.transition = value ? "visibility 0s linear 0s, opacity 0.3s linear" : "visibility 0s linear 0.3s, opacity 0.3s linear";
        },
    },
};
</script>

<style>
@import url(./assets/styles.css);

.rc-anchor-normal .rc-anchor-pt {
    margin: 2px 10px 0 0;
    padding-right: 0px;
}

body {
    margin-top: 4rem;
    margin-left: 4rem;
}
</style>
