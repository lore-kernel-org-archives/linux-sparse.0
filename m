From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 00/12] x86, kbuild: revert macrofying inline assembly code
Date: Wed, 19 Dec 2018 12:19:13 +0900
Message-ID: <CAK7LNAR-uayGwbzmvezVO1w6N4AJaLe07ctYt-P6VHQv3PczZw@mail.gmail.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com> <C6D4A9B6-EED6-4DF7-8085-B1D3D221D25A@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C6D4A9B6-EED6-4DF7-8085-B1D3D221D25A@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <namit@vmware.com>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Richard Biener <rguenther@suse.de>, Segher Boessenkool <segher@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Alok Kataria <akataria@vmware.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jann Horn <jannh@google.com>, linux-arch <linux-arch@vger.kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Andrew
List-Id: linux-sparse@vger.kernel.org

On Wed, Dec 19, 2018 at 5:26 AM Nadav Amit <namit@vmware.com> wrote:
>
> > On Dec 17, 2018, at 8:03 AM, Masahiro Yamada <yamada.masahiro@socionext=
.com> wrote:
> >
> > This series reverts the in-kernel workarounds for inlining issues.
> >
> > The commit description of 77b0bf55bc67 mentioned
> > "We also hope that GCC will eventually get fixed,..."
> >
> > Now, GCC provides a solution.
> >
> > https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgcc.=
gnu.org%2Fonlinedocs%2Fgcc%2FExtended-Asm.html&amp;data=3D02%7C01%7Cnamit%4=
0vmware.com%7Cc43f433d8c6244de15f108d6643a49e4%7Cb39138ca3cee4b4aa4d6cd83d9=
dd62f0%7C0%7C0%7C636806598899962669&amp;sdata=3D88UJ25RoiHik9vTCJKZV6%2F7xp=
zCGsvKb9LFg1kfEYL0%3D&amp;reserved=3D0
> > explains the new "asm inline" syntax.
> >
> > The performance issue will be eventually solved.
> >
> > [About Code cleanups]
> >
> > I know Nadam Amit is opposed to the full revert.
>
> My name is Nadav.


Sorry about that.

(I relied on a spell checker. I should be careful about typos in people's n=
ame.)



> > He also claims his motivation for macrofying was not only
> > performance, but also cleanups.
>
> Masahiro, I understand your concerns and criticism, and indeed various
> alternative solutions exist. I do have my reservations about the one you
> propose, since it makes coding more complicated to simplify the Make syst=
em.
> Yet, more important, starting this discussion suddenly now after RC7 is
> strange.



I did not think this was so sudden.

When I suggested the revert a few weeks ago,
Borislav was for it.
I did not hear from the other x86 maintainers.

Anyway, it is true we are running out of time for the release.


> Anyhow, since it=E2=80=99s obviously not my call, please don=E2=80=99t ma=
ke it
> sound as if I am a side in the decision.
>

Not my call, either.

That's why I put the x86 maintainers in the TO list,
and other people in CC.

The original patch set went in via x86 tree.
So, its revert set, if we want,
should go in the same path.



Anyway, we have to do something for v4.20.
Maybe, discussing short-term / long-term solutions
separately could move things forward.


[1] Solution for v4.20

[2] Solution for future kernel



If we do not want to see the revert for [1],
the best I can suggest is to copy arch/x86/kernel/macros.s
to include/generated/macros.h
so that it is kept for the external module build.
(It is not literally included by anyone, but should work at least.)



For [2], what do we want to see?




--=20
Best Regards
Masahiro Yamada
