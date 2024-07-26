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

However, the issue in trying to beat reCAPTCHAv2 remains that none of the experiments are reproducible (assuming that code is provided) because reCAPTCHAv2 is closed-source and the dataset is not publicly available.

This project aims to change that by providing a reCAPTCHAv2 clone [^diff] for research purposes. The clone is built with the same principles as reCAPTCHAv2, but with a few modifications to make it easier to work with.

To get started simply update the `./attack/main.py` file with your solver and run `make docker-install` to run the frontend on `localhost:8080` to be scraped by your solver.

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

[^diff]: The most significant differences: (1) In the object detection task there must always be at least one object to click, (2) the audio challenge is not implemented, (3) the endless-object-detection task is not implemented in which the task is to stop clicking when there are no more objects left to click in contrast to the original reCAPTCHAv2 where the task is to click all objects and click `Verify` when done.
