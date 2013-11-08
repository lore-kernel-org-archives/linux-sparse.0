From: Schrober <franzschrober@yahoo.de>
Subject: Re: Novafora relicenses Transmeta sparse copyrights under the MIT license
Date: Fri, 08 Nov 2013 17:13:08 +0100
Message-ID: <5578017.bROrmTJuHL@bentobox>
References: <49E51310.3050005@zytor.com> <1778650.2HXIBSXfmv@bentobox> <20131107212415.GV26669@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm8-vm1.bullet.mail.ird.yahoo.com ([77.238.189.198]:24402 "HELO
	nm8-vm1.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756972Ab3KHQNO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Nov 2013 11:13:14 -0500
In-Reply-To: <20131107212415.GV26669@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Friday 08 November 2013 00:24:15 Dan Carpenter wrote:
> I have attached a tar ball of people who agreed to the relicense.
>=20
> It's really late here so I can help you go through it tomorrow if you
> have any questions.

Sorry your mail ended up inside the spam folder and I've only monitored=
 the=20
mailing list [1] for your mail.

The people which need extra work to get their changes relicensed under =
the MIT=20
are

 * Adam DiCarlo <bikko@us.ibm.com>
   minor enhancement 8ea2cc615de7546d057fe0ed8ab2f7af278e6b2c
 * Benjamin Herrenschmidt <benh@kernel.crashing.org>
   minor bugfix 9c2ffd7b21e8e880243eaec40e9dbc66651b085c
 * Chris Wedgwood <cw@f00f.org>
   minor bugfixes 8fae62236344076f8f0113ed21bedaf45ccec43d
    dc4240e8b621ada294409782128e6d393b622cd1
 * Ethan Jackson <ethan@nicira.com>
   minor fix b0b4886be5f668959b8c75c9c811059e07b1073a
 * Frederic Crozat <fcrozat@suse.com>
   minor addition 8ab3b11aa5cf9f68e374fc297d4f285a65e706a1
 * James Westby <jw+debian@jameswestby.net>
   minor fixes 34ac7df96dd9609d684b0c949a52bc07ab1fd8b5
    006eff06c7adcfb0d06c6fadf6e9b64f0488b2bf
 * Jan Pokorn=FD <pokorny_jan@seznam.cz>
   minor fixes 955cd225d2e3ee708e20de825eca82c8797897fd
    695dd9d068dd2316b92706d174df9e30c1e71dcf
   minor cleanups 05e666547ee05acadf7fed2d1fc9967c27739e9a
    7988e483ef47abb97004d7fb7f72b7037aa06bb6
    0c7d6bffbccead5fdf0897d575b12e389496c9d7
    b21baf0cce7b2a6c949577952dd159f1c9357d6b
 * Joe Perches <joe@perches.com>
   add of --version bcdb5ee5a83fbe2779cc6e49ab1fa87c50a20805
 * Kim Phillips <kim.phillips@freescale.com>
   minor fix 8e42bac6efcb047a2b3d812e42c00f82e3b8a984
 * KOSAKI Motohiro <kosaki.motohiro@gmail.com>
   minor fixes 0a04210cc856267d8371592dc55f8b8bb7596ecc
    2313167a83c397e8acc14d10706a7235f60fc497
 * Kovarththanan Rajaratnam <krj@rajaratnam.dk>
   minor fix ed450b3079832a4c92d0ba2110e4e9efd35ed339
 * Luc Van Oostenryck <lkml@looxix.net>, <luc.vanoostenryck@looxix.net>
   minor fixes 98346fe1671f052d4b2c7b36229235c64bb31a32
    aa163fa6869f050cd157afef23b82cc3bc14cb61
    269bcb9b9334057928d9c6eebd8555c88ebd3f2d
    0947976f74810d492fea90a4ddcd0f2d36ded535
    3ff22243cbc38719ab16d8c1f25605892337012b
    2cec905cb5d11e5b3a928f1038788d7c23a1cc33
    409eab7c1a8f1bd76d2a56428d01ad9d5938fb14
    fbaf5e4bc98b95d9350495a51bc89e4e7dddba4c
    e2559ab1f5d44c4708c60ff8cae240a854b56d34
    0feb9170ed4aad6a2c54f2850eb3d845cde77845
    d225b6dbdd931411ffb4bbf96ea2567ce572a9c4
    260a278aefde836683ea9a7e68f3983030338f39
    fafb86f96d323c9b23e8519987adc195e031f456
    faa939b386004bdb1c2aaf277f6fb7ac333f89d3
    98346fe1671f052d4b2c7b36229235c64bb31a32
    3ce2538d18c6bad49bc1acfbe41375fc54f3e0ad
    4cebb70b009aa80b63115c6bbae7428bcf17b652
    5213bc46472b1181aa6111b5d4814a0fbca69282
   rewrite 6690a7f7a4fbd4cd606e01b7feef678058cf4635
   add 4c520e1ad243ed347dfc0e1f8c6e3dec19994f42
    ca682df2d73399c4d24d4400cc1a06c9dfc79477
 * Masatake YAMATO <yamato@redhat.com>
   minor addition 3b1e38c703f8a3daea26b7d201442d8e74bbe199
    92c321cfd154a328d3bf0ce0e8b325cf1f70b1d0
    c3430e57bc57ff40d5ce95ef2d26b8d70346f58f
 * Mauro Dreissig <mukadr@gmail.com>
   minor fix 7a1da692083c1d9d2e604df89ed553fd2ede9907
 * Peter Jones <pjones@redhat.com>
   minor fix ce4b69f9e7878a7c7041b5f9cee587ed0d82e8cf
 * Peter A Jonsson <pj@ludd.ltu.se>
   minor fix fd59b219733d711b36ac70038fcb7496e4501920
 * Richard Knutsson <ricknu-0@student.ltu.se>
   minor refactoring cd4288f195f11f6c0a78bca03db009a0494da7cc
    318447b069ba9e9a403ca764be7e3924d2121142
    5b0858930b6a1097dbda6ceef6764070a73fd923
   minor fix 58af88c40f307476ffa482ed16b5e0586fea1b6f
 * rmps@joel.ist.utl.pt <rmps@joel.ist.utl.pt>
   minor fix 6f593900adbe226fbf55d5095d20e15c8fbc2304
 * Santtu Hyrkk=1B,Av=1B(B <santtu.hyrkko@gmail.com>
   minor fix 0c62759dd20ef959b01679413b475a9b5e226e4e
 * Shakthi Kannan <shakthimaan@gmail.com>
   manpage additions 970d7169d75068146152ba01a66381c800dbeb71
 * Xi Wang <xi.wang@gmail.com>
   minor fixes c0296d71405a97349d82e9909cad82a2af3271c2
    99bdda1a38a6e3622cb72f422b2fb05045c29df7
    469e5d6ea3353fb3039747f52fb506c9ba983d8b
    317876877c7c818c5cfd69da7bb45174b6ddadd4
    5b950a99d4a81db8581741def3ea6acf05b0b493
    4858eafe71ea9cd6e61a8ee2883e2cde28430f20
    bf6b5e73f4884270eb14dace0ba3598b9dc61b24
    0830fefd080cb921e89e4dae847803f3ed6efdd4
    f79914429cb466d1085a2a6204b38101ca75c608
    652eb801d2141b57dca3215e71c55e8356b407a2
    afa3245c069c532f3a88bf0053113c54480a1c1d
    4c982e9d3c6827afb529c7c7ce7fbe987eac24c6
  larger additions/fixes(?) 08d9fbaeda48e20a76206d550ac5ab5b2c60d99e
   e33b721d954a0c59ca1c09e75ec0657e0c3e0391
   b17550b274916fc5a4b6f89a3f95572e6f9bce7f
   0448f78f5fae84b8a9c1358129a03ea24e593b34
   64a6b4c61faa23c40a402656d044141a669965a3

Please keep in mind that the minor just says "propably not copyrightabl=
e" and=20
not "nobody cares about this contribution". Every contribution is good.

The biggest "problem" seems to be Luc Van Oostenryck. Are we sure he is=
 still=20
alive? Because I have problems finding some working address for him. Ma=
ybe=20
someone could try to contact him through linkedin or some other form.

[1] http://thread.gmane.org/gmane.comp.parsers.sparse/1799
--=20
=46ranz Schrober
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
