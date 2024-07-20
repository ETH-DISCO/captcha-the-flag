<template>
    <div>
        <p>solve me if you can.</p>

        <!-- modal buttons -->
        <section>
            <!-- modal open button -->
            <div style="width: 304px; height: 78px" @click="openModal" ref="container">
                <div id="rc-anchor-alert" class="rc-anchor-alert"></div>
                <div id="rc-anchor-container" class="rc-anchor rc-anchor-normal rc-anchor-light" style="position: relative">
                    <div id="recaptcha-accessible-status" class="rc-anchor-aria-status" aria-hidden="true">Please verify yourself.</div>
                    <div class="rc-anchor-error-msg-container" style="display: none">
                        <span class="rc-anchor-error-msg" aria-hidden="true"></span>
                    </div>
                    <div class="rc-anchor-content">
                        <div class="rc-inline-block">
                            <div class="rc-anchor-center-container">
                                <div class="rc-anchor-center-item rc-anchor-checkbox-holder">
                                    <!-- loading spinner-->
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
                        <div class="rc-inline-block">
                            <div class="rc-anchor-center-container">
                                <label class="rc-anchor-center-item rc-anchor-checkbox-label" aria-hidden="true" role="presentation" id="recaptcha-anchor-label">
                                    <!-- message -->
                                    <span aria-live="polite" aria-labelledby="recaptcha-accessible-status"></span> I'm not a robot
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

            <!-- modal close button (transparent background layer) -->
            <div @click="SHOW_MODAL = false" style="width: 100%; height: 100%; position: fixed; top: 0px; left: 0px; z-index: 2000000000; background-color: rgb(255, 255, 255); opacity: 0" v-show="SHOW_MODAL"></div>
        </section>

        <!-- modal -->
        <section :style="MODAL_STYLE">
            <header>
                <div v-show="IS_DESKTOP_MODE" class="g-recaptcha-bubble-arrow" style="border-width: 11px; border-style: solid; border-color: transparent rgb(204, 204, 204) transparent transparent; border-image: initial; width: 0px; height: 0px; position: absolute; pointer-events: none; margin-top: -11px; z-index: 2000000000; top: 35px; right: 100%"></div>
                <div v-show="IS_DESKTOP_MODE" class="g-recaptcha-bubble-arrow" style="border-width: 10px; border-style: solid; border-color: transparent rgb(255, 255, 255) transparent transparent; border-image: initial; width: 0px; height: 0px; position: absolute; pointer-events: none; margin-top: -10px; z-index: 2000000000; top: 35px; right: 100%"></div>
            </header>

            <main id="rc-imageselect">
                <div id="rc-imageselect">
                    <div class="rc-imageselect-response-field"></div>
                    <span class="rc-imageselect-tabloop-begin" tabindex="0"></span>
                    <div class="rc-imageselect-payload">
                        <!-- task instructions -->
                        <div class="rc-imageselect-instructions" style="margin-bottom: 7px" ref="instructions">
                            <div class="rc-imageselect-desc-wrapper">
                                <div class="rc-imageselect-desc-no-canonical" style="font-size: 12px">
                                    Select all squares with<strong style="font-size: 28px">{{ SEARCH_QUERY }}</strong>
                                    If there are none, click verify
                                </div>
                            </div>
                            <div class="rc-imageselect-progress"></div>
                        </div>

                        <div class="rc-imageselect-challenge">
                            <div id="rc-imageselect-target" class="rc-imageselect-target" dir="ltr" role="presentation" aria-hidden="true">
                                <table class="rc-imageselect-table-33">
                                    
                                    <!-- segmentation task -->
                                    <tbody>
                                        <tr v-for="tr in 3" :key="tr">
                                            <td
                                                role="button" tabindex="0" class="rc-imageselect-tile" aria-label="image verification"
                                                :class="{ 'rc-imageselect-tileselected': SELECTIONS.includes(tr + '_' + td) }"
                                                v-for="td in 3" :key="td"
                                                @click="selectField(tr + '_' + td)"
                                            >
                                                <div class="rc-image-tile-target">
                                                    <div class="rc-image-tile-wrapper" :style="{ width: TILE_SIZE_PX + 'px', height: TILE_SIZE_PX + 'px' }">
                                                        <img
                                                            class="rc-image-tile-33"
                                                            :src="require('@/assets/images/hcaptcha/boat/' + FILENAME)"
                                                            :style="{ top: '-' + (tr - 1) * 100 + '%', left: '-' + (td - 1) * 100 + '%' }"
                                                        />
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
                        <div class="rc-imageselect-incorrect-response" v-show="ERROR_TYPE == 'rc-imageselect-incorrect-response'">Please try again.</div>
                        <div class="rc-imageselect-error-select-more" v-show="ERROR_TYPE == 'rc-imageselect-error-select-more'">Please select all images that apply.</div>
                    </div>
                </div>
            </main>

            <footer>
                <div class="rc-footer">
                    <div class="rc-separator"></div>
                    <div class="rc-controls">
                        <div class="primary-controls">
                            <!-- reload button -->
                            <div class="rc-buttons">
                                <div class="button-holder reload-button-holder">
                                    <button class="rc-button goog-inline-block rc-button-reload" title="Change your verification code" value="" id="recaptcha-reload-button" tabindex="0" @click="nextTask"></button>
                                </div>
                                <div class="button-holder help-button-holder">
                                    <a href="https://support.google.com/recaptcha/?hl=en" target="_blank" rel="noopener noreferrer" class="rc-button goog-inline-block rc-button-help" title="help" value="" id="recaptcha-help-button" tabindex="0"></a>
                                </div>
                            </div>
                            <!-- submission button -->
                            <div class="verify-button-holder">
                                <button class="rc-button-default goog-inline-block" title="" value="" id="recaptcha-verify-button" :class="{ 'rc-button-default-disabled': IS_LOADING_RESULT }" tabindex="0" @click="verify">verify</button>
                            </div>
                        </div>
                        <div class="rc-challenge-help" style="display: none" tabindex="0"></div>
                    </div>
                </div>
                <span class="rc-imageselect-tabloop-end" tabindex="0"></span>
            </footer>
        </section>
    </div>
</template>

<script>
import "typeface-roboto";
import delay from "delay";
import { DETECTION_TASK_PATH, SEGMENTATION_TASK_PATH } from '@/config/config';

const randomDelay = (a, b) => delay(Math.floor(Math.random() * (b - a + 1)) + a);

/*
task types: https://tik-db.ee.ethz.ch/file/7243c3cde307162630a448e809054d25/#page=2
*/

export default {
    // initial state of component
    data() {
        return {
            // modal
            SHOW_MODAL: false,

            // task constants
            DETECTION_TASK_PATH, // directory where each subdirectory contains images of a single class
            SEGMENTATION_TASK_PATH, // directory containing images with multiple classes (... not implemented yet)

            // task
            TASK: {},

            FILENAME: null,
            SEARCH_QUERY: null,
            SELECTIONS: [],
            ERROR_TYPE: "",
            
            // styling
            IS_LOADING_MODAL: false,
            IS_LOADING_RESULT: false,
            IS_DESKTOP_MODE: false,
            MODAL_STYLE: { "background-color": "rgb(255, 255, 255)", border: "1px solid rgb(204, 204, 204)", "box-shadow": " rgb(0 0 0 / 20%) 2px 2px 3px", position: "absolute", transition: "visibility 0s linear 0s, opacity 0.3s linear 0s", opacity: "1", "z-index": "2000000000", visibility: "hidden" },
            TILE_SIZE_PX: 126,
        };
    },

    watch: {
        // reactive properties
        SHOW_MODAL(value) {
            this.reRenderModal();
            this.MODAL_STYLE.visibility = value ? "visible" : "hidden";
            this.MODAL_STYLE.opacity = value ? "1" : "0";
            this.MODAL_STYLE.transition = value ? "visibility 0s linear 0s, opacity 0.3s linear" : "visibility 0s linear 0.3s, opacity 0.3s linear";
        },
    },
    created() {
        // ran before DOM is mounted
        this.nextTask();
    },
    mounted() {
        // ran after DOM is mounted
        window.addEventListener("resize", () => {
            if (this.SHOW_MODAL) {
                this.reRenderModal();
            }
        });
    },

    methods: {
        /*
         * modal logic
         */

        async openModal() {
            this.IS_LOADING_MODAL = true;
            await this.nextTask();

            await randomDelay(250, 300);
            this.SHOW_MODAL = true;
            await randomDelay(250, 300);
            this.IS_LOADING_MODAL = false;
        },

        /*
         * task logic
         */

        async nextTask() {
            // reset
            this.SELECTIONS = [];
            this.IS_LOADING_RESULT = true;

            // generate task
            const images = require.context("@/assets/images/hcaptcha/boat/", true, /^.*\.(png|jpe?g)$/).keys().map((x) => x.replace("./", ""));
            const getRandomImage = () => images[Math.floor(Math.random() * images.length)];
            
            const searchQueries = ["airplane", "bicycle", "boat", "motorbus", "motorcycle", "seaplane", "train", "truck"];
            const getRandomSearchQuery = () => searchQueries[Math.floor(Math.random() * searchQueries.length)];
            
            const fn = this.FILENAME;
            while (fn == this.FILENAME) {
                this.FILENAME = getRandomImage();
            }
            const sq = this.SEARCH_QUERY;
            while (sq == this.SEARCH_QUERY) {
                this.SEARCH_QUERY = getRandomSearchQuery();
            }

            await randomDelay(300, 400);
            this.IS_LOADING_RESULT = false;
        },

        async showError(errorType) {
            this.ERROR_TYPE = errorType;
            
            await randomDelay(1000, 1500); // let user read
            this.ERROR_TYPE = null;
        },

        async verify() {
            if (this.SELECTIONS.length < 2) {
                console.log("didn't select sufficient images");
                return this.showError("rc-imageselect-error-select-more");
            }

            this.IS_LOADING_RESULT = true;
            await randomDelay(300, 700);
            
            // ... some logic where you check the selections
            
            let isCorrect = false;
            if (isCorrect) {
                console.log("correct");
            } else {
                console.log("incorrect");
                await this.showError("rc-imageselect-incorrect-response");
            }
            
            await this.nextTask();
        },

        async selectField(key) {
            if (this.IS_LOADING_RESULT) {
                console.log("already submitted selections");
                return;
            }
            if (this.SELECTIONS.includes(key)) {
                return (this.SELECTIONS = this.SELECTIONS.filter((x) => x != key));
            }
            console.log("selected", key);
            console.log("selections", this.SELECTIONS);
            this.SELECTIONS.push(key);
        },

        /*
         * styling logic
         */

        async reRenderModal() {
            const isMobile = window.innerWidth < 470;
            this.IS_DESKTOP_MODE = !isMobile;
            if (isMobile) {
                this.MODAL_STYLE.width = window.innerWidth - 5 + "px";
                this.TILE_SIZE_PX = Math.floor((window.innerWidth - 5) / 3) - 7.55555;
                this.MODAL_STYLE.left = 0;
                this.MODAL_STYLE.right = 0;
                this.MODAL_STYLE.margin = "auto";
            } else {
                const bcr = this.$refs.container.getBoundingClientRect();
                this.MODAL_STYLE.width = "408px";
                this.TILE_SIZE_PX = 128.5;
                this.MODAL_STYLE.left = isMobile ? 0 : bcr.left + 51 + "px";
                this.MODAL_STYLE.top = bcr.top + 2 + "px";
                delete this.MODAL_STYLE.margin;
            }
        }
    }
};
</script>

<style>
@import url(./assets/styles.css);

.rc-anchor-normal .rc-anchor-pt {
    margin: 2px 10px 0 0;
    padding-right: 0px;
}

body {
    margin-top: 10vh;
    margin-left: 10vw;
}
</style>
