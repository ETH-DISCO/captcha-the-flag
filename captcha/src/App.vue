<template>
    <div>
        <p>solve me if you can.</p>
        <p>success rate: {{ CORRECT }} / {{ ATTEMPTS }}</p>
        
        <br />

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
                                        <!-- checkmark animation (disabled) -->
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
                                    <div v-if="TASK_TYPE == 'detection'">
                                        Select all images with<strong style="font-size: 28px">{{ SEARCH_QUERY }}</strong>
                                    </div>
                                    <div v-if="TASK_TYPE == 'segmentation'">
                                        Select all images with<strong style="font-size: 28px">{{ SEARCH_QUERY }}</strong>
                                    </div>
                                </div>
                            </div>
                            <div class="rc-imageselect-progress"></div>
                        </div>

                        <!-- task -->
                        <div class="rc-imageselect-challenge">
                            <div id="rc-imageselect-target" class="rc-imageselect-target" dir="ltr" role="presentation" aria-hidden="true">
                                <table class="rc-imageselect-table-33">

                                    <div v-if="TASK_TYPE == 'detection'">
                                        <tbody>
                                            <tr v-for="tr in 3" :key="tr">
                                                <td role="button" tabindex="0" class="rc-imageselect-tile" aria-label="image verification" :class="{ 'rc-imageselect-tileselected': SELECTIONS.includes(tr + '_' + td) }" v-for="td in 3" :key="td" @click="selectField(tr + '_' + td)">
                                                    <div class="rc-image-tile-target">
                                                        <img class="rc-image-tile-33" :style="{ width: TILE_SIZE_PX + 'px', height: TILE_SIZE_PX + 'px' }" :src="COORD_CLS_IMG[tr + '_' + td][1]" />
                                                        <div class="rc-image-tile-overlay"></div>
                                                        <div class="rc-imageselect-checkbox"></div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </div>

                                    <div v-if="TASK_TYPE == 'segmentation'">
                                        <tbody>
                                            <tr v-for="tr in 4" :key="tr">
                                                <td role="button" tabindex="0" class="rc-imageselect-tile" aria-label="image verification" :class="{ 'rc-imageselect-tileselected': SELECTIONS.includes(tr + '_' + td) }" v-for="td in 4" :key="td" @click="selectField(tr + '_' + td)">
                                                    <div class="rc-image-tile-target">
                                                        <div class="rc-image-tile-wrapper" :style="{ width: TILE_SIZE_PX + 'px', height: TILE_SIZE_PX + 'px' }">
                                                            <img class="rc-image-tile-44" :style="{ top: '-' + (tr - 1) * 100 + '%', left: '-' + (td - 1) * 100 + '%' }" :src="COORD_CLS_IMG['1_1'][1]" />
                                                            <div class="rc-image-tile-overlay"></div>
                                                            <div class="rc-imageselect-checkbox"></div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </div>

                                </table>
                            </div>
                        </div>

                        <!-- messages -->
                        <div class="rc-error-msg" v-show="MSG_TYPE == 'incorrect-response'">Please try again.</div>
                        <div class="rc-error-msg" v-show="MSG_TYPE == 'incorrect-select-more'">Please select all images that apply.</div>
                        <div class="rc-success-msg" v-show="MSG_TYPE == 'correct-response'">Correct.</div>
                    </div>
                </div>
            </main>

            <footer>
                <div class="rc-footer">
                    <div class="rc-separator"></div>
                    <div class="rc-controls">
                        <div class="primary-controls">
                            <!-- reset and help buttons -->
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
import { DETECTION_DIR, SEGMENTATION_DIR } from "./config";

const randomDelay = (a, b) => delay(Math.floor(Math.random() * (b - a + 1)) + a);

const taskEnum = Object.freeze({
    DETECTION: "detection",
    SEGMENTATION: "segmentation",
});

// webpack doesn't support dynamic require.context
const rootDirs = require
    .context("/public/images", true, /.+/)
    .keys()
    .map((x) => x.replace("./", "/images/"))
    .reduce((acc, x) => {
        const dir = x.split("/")[2];
        if (!acc[dir]) {
            acc[dir] = [];
        }
        acc[dir].push(x);
        return acc;
    }, {});

export default {
    data() {
        return {
            // success rate
            ATTEMPTS: 0,
            CORRECT: 0,

            // modal states
            SHOW_MODAL: false,

            // task states
            TASK_TYPE: null,
            COORD_CLS_IMG: {},
            SELECTIONS: [],
            MSG_TYPE: "",

            // styling states
            SEARCH_QUERY: null,
            IS_LOADING_MODAL: false,
            IS_LOADING_RESULT: false,
            IS_DESKTOP_MODE: false,
            MODAL_STYLE: { "background-color": "rgb(255, 255, 255)", border: "1px solid rgb(204, 204, 204)", "box-shadow": " rgb(0 0 0 / 20%) 2px 2px 3px", position: "absolute", transition: "visibility 0s linear 0s, opacity 0.3s linear 0s", opacity: "1", "z-index": "2000000000", visibility: "hidden" },
            TILE_SIZE_PX: 0,
        };
    },

    watch: {
        SHOW_MODAL(value) {
            this.reRenderModal();
            this.MODAL_STYLE.visibility = value ? "visible" : "hidden";
            this.MODAL_STYLE.opacity = value ? "1" : "0";
            this.MODAL_STYLE.transition = value ? "visibility 0s linear 0s, opacity 0.3s linear" : "visibility 0s linear 0.3s, opacity 0.3s linear";
        },
    },
    created() {
        this.nextTask();
    },
    mounted() {
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
            const reset = () => {
                this.SELECTIONS = [];
                this.IS_LOADING_RESULT = false;
                this.MSG_TYPE = "";
            };
            reset();

            // const task = Object.values(taskEnum)[Math.floor(Math.random() * Object.values(taskEnum).length)];
            const task = taskEnum.DETECTION;
            this.TASK_TYPE = task;
            if (task == taskEnum.DETECTION) {
                const detectionDir = rootDirs[DETECTION_DIR];
                const classImgs = detectionDir.reduce((acc, x) => {
                    const cls = x.split("/")[3];
                    if (!acc[cls]) {
                        acc[cls] = [];
                    }
                    acc[cls].push(x);
                    return acc;
                }, {});
                for (let i = 1; i < 4; i++) {
                    for (let j = 1; j < 4; j++) {
                        const coord = `${i}_${j}`;
                        const cls = Object.keys(classImgs)[Math.floor(Math.random() * Object.keys(classImgs).length)];
                        const img = classImgs[cls][Math.floor(Math.random() * classImgs[cls].length)];
                        this.COORD_CLS_IMG[coord] = [cls, img];
                    }
                }
                this.SEARCH_QUERY = Object.values(this.COORD_CLS_IMG)[Math.floor(Math.random() * 9)][0];
                this.TILE_SIZE_PX = 126;
            } else if (task == taskEnum.SEGMENTATION) {
                const segmentationDir = rootDirs[SEGMENTATION_DIR];
                const rndClass = segmentationDir[Math.floor(Math.random() * segmentationDir.length)].split("/")[3];
                const classImgs = segmentationDir.filter((x) => x.split("/")[3] == rndClass);
                const rndImg = classImgs[Math.floor(Math.random() * classImgs.length)];
                let trueCoords = rndImg.split("/")[4].split(",").map((x) => parseInt(x));
                trueCoords = [...new Set(trueCoords)];
                for (let i = 1; i < 5; i++) {
                    for (let j = 1; j < 5; j++) {
                        const coord = `${i}_${j}`;
                        const idx = (i - 1) * 4 + j - 1;
                        const isTrue = trueCoords.includes(idx);
                        this.COORD_CLS_IMG[coord] = [isTrue, rndImg];
                    }
                }
                this.SEARCH_QUERY = rndClass;
                this.TILE_SIZE_PX = 94;
            } else {
                console.error("task not found");
            }

            await randomDelay(300, 400);
            this.IS_LOADING_RESULT = false;
        },

        async showMsg(errorType) {
            this.MSG_TYPE = errorType;

            await randomDelay(1000, 1500);
            this.MSG_TYPE = null;
        },

        async verify() {
            if (this.SELECTIONS.length < 1) {
                console.log("didn't select sufficient images");
                return this.showMsg("incorrect-select-more");
            }

            this.IS_LOADING_RESULT = true;
            await randomDelay(300, 700);

            let isCorrect = false;
            if (this.TASK_TYPE == taskEnum.DETECTION) {
                isCorrect = this.SELECTIONS.every((x) => this.COORD_CLS_IMG[x][0] == this.SEARCH_QUERY);
            } else if (this.TASK_TYPE == taskEnum.SEGMENTATION) {
                isCorrect = this.SELECTIONS.every((x) => this.COORD_CLS_IMG[x][0] == true);
            } else {
                console.error("task not found");
            }

            if (isCorrect) {
                console.log("correct");
                await this.showMsg("correct-response");
                await randomDelay(800, 1200);
                this.CORRECT++;
                await this.nextTask();
            } else {
                console.log("incorrect");
                await this.showMsg("incorrect-response");
                await this.nextTask();
            }
            this.ATTEMPTS++;
        },

        async selectField(key) {
            if (this.IS_LOADING_RESULT) {
                console.log("already submitted selections");
                return;
            }
            if (this.SELECTIONS.includes(key)) {
                return (this.SELECTIONS = this.SELECTIONS.filter((x) => x != key));
            }
            this.SELECTIONS.push(key);


            const log = () => {
                const isTrue = (key) => {
                    if (this.TASK_TYPE == taskEnum.DETECTION) {
                        return this.COORD_CLS_IMG[key][0] == this.SEARCH_QUERY;
                    } else if (this.TASK_TYPE == taskEnum.SEGMENTATION) {
                        return this.COORD_CLS_IMG[key][0] == true;
                    } else {
                        console.error("task not found");
                    }
                }
                const allTrue = Object.keys(this.COORD_CLS_IMG).filter((x) => isTrue(x));
                console.log("selected", key, " - ", isTrue(key), " - ", allTrue);
            }
            log();
        },

        async reRenderModal() {
            const isMobile = window.innerWidth < 470;
            this.IS_DESKTOP_MODE = !isMobile;
            if (isMobile) {
                this.MODAL_STYLE.width = window.innerWidth - 5 + "px";
                // this.TILE_SIZE_PX = Math.floor((window.innerWidth - 5) / 3) - 7.55555;
                this.MODAL_STYLE.left = 0;
                this.MODAL_STYLE.right = 0;
                this.MODAL_STYLE.margin = "auto";
            } else {
                const bcr = this.$refs.container.getBoundingClientRect();
                this.MODAL_STYLE.width = "408px";
                // this.TILE_SIZE_PX = 128.5;
                this.MODAL_STYLE.left = isMobile ? 0 : bcr.left + 51 + "px";
                this.MODAL_STYLE.top = bcr.top + 2 + "px";
                delete this.MODAL_STYLE.margin;
            }
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
    margin: 10vh;
}
</style>
