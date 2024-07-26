<p align="center">
  <img src="./docs/logo.png" style="width: 10%" align="left">
  <h3>CAPTCHA the Flag</h3>
  <p>
    The reCAPTCHAv2 solving challenge.
  </p>
</p>

<br>

![screen](./docs/screenshot.png)

<br>

Solving Google's reCAPTCHAv2 with high accuracy has become an exciting computer vision challenge that lets models compete against humans on a level playing field to pass a Turing test.
Previous solutions have shown that it is possible to achieve a success rate of 92-98% [^2] [^8] [^18] [^9] and most recently 100% as demonstrated by Plesner et al. [^16].

However, the issue in trying to beat reCAPTCHAv2 remains that none of the experiments are reproducible, given that the code is not available or the dataset is not public.

This repository aims to provide a reproducible environment to train and evaluate models on the reCAPTCHAv2 challenge by providing a vast dataset of over 100,000 images and a very close lookalike of reCAPTCHAv2 [^diff]

# References

[^2]: Björklund, Arvid and Uogele, Marius. Classifying Google reCAPTCHA v2 - A study
using transfer learning models and evaluating their robustness against adversarial perturbations, 2023. Student Paper.

[^8]: I Hossen, Yazhou Tu, F Rabby, Md Nazmul Islam, Hui Cao, and Xiali Hei. Bots work
better than human beings: An online system to break google’s image-based recaptcha
v2. 2019.

[^18]: Krish Sukhani, Sahil Sawant, Sarthak Maniar, and Renuka Pawar. Automating the
bypass of image-based captcha and assessing security. In 2021 12th International Conference on Computing Communication and Networking Technologies (ICCCNT), pages
01–08. IEEE, 2021.

[^9]: Md Imran Hossen, Yazhou Tu, Md Fazle Rabby, Md Nazmul Islam, Hui Cao, and Xiali
Hei. An object detection based solver for {Google’s} image {reCAPTCHA} v2. In 23rd
international symposium on research in attacks, intrusions and defenses (RAID 2020),
pages 269–284, 2020.

[^16]: Andreas Plesner, Tobias Vontobel, and Roger Wattenhofer. Breaking recaptchav2.
In 48th IEEE International Conference on Computers, Software, and Applications
(COMPSAC 2024). IEEE, 2024.

[^diff]: Very obvious differences being that every task must always contain a correct answer and that we have not implemented the audio challenge or the endless-object-detection task (in which the task is to stop clicking when there are no more objects to click rather than just to click all relevant objects).
