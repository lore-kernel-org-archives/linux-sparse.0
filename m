From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC PATCH 17/48] dump-ir: rename -fdump-linearize to -fdump-ir
Date: Sun, 27 Aug 2017 00:44:10 -0400
Message-ID: <CANeU7Qnhm4T1_baixTMyP06oDXAW2r6LU8j34K0JsFcUQUmdBw@mail.gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com> <20170823201554.90551-18-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:38718 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbdH0EoL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 27 Aug 2017 00:44:11 -0400
Received: by mail-yw0-f193.google.com with SMTP id e9so1841094ywh.5
        for <linux-sparse@vger.kernel.org>; Sat, 26 Aug 2017 21:44:11 -0700 (PDT)
In-Reply-To: <20170823201554.90551-18-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

FYI, this one and the few follows does not have a signed off.
I assume you will add commit messages and signed off later.

Chris


On Wed, Aug 23, 2017 at 4:15 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> ---
>  cgcc                                   |  2 +-
>  lib.c                                  | 10 +++++-----
>  lib.h                                  |  2 +-
>  linearize.c                            |  4 ++--
>  sparse.1                               |  2 +-
>  validation/linear/bitfield-init-mask.c |  2 +-
>  6 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/cgcc b/cgcc
> index a8d7b4f21..644627109 100755
> --- a/cgcc
> +++ b/cgcc
> @@ -103,7 +103,7 @@ sub check_only_option {
>      my ($arg) =3D @_;
>      return 1 if $arg =3D~ /^-W(no-?)?(address-space|bitwise|cast-to-as|c=
ast-truncate|context|decl|default-bitfield-sign|designated-init|do-while|en=
um-mismatch|init-cstring|memcpy-max-count|non-pointer-null|old-initializer|=
one-bit-signed-bitfield|override-init-all|paren-string|ptr-subtraction-blow=
s|return-void|sizeof-bool|sparse-all|sparse-error|transparent-union|typesig=
n|undef|unknown-attribute)$/;
>      return 1 if $arg =3D~ /^-v(no-?)?(entry|dead)$/;
> -    return 1 if $arg =3D~ /^-f(dump-linearize|memcpy-max-count)(=3D\S*)?=
$/;
> +    return 1 if $arg =3D~ /^-f(dump-ir|memcpy-max-count)(=3D\S*)?$/;
>      return 0;
>  }
>
> diff --git a/lib.c b/lib.c
> index c46798d0f..a0ed29c3e 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -258,7 +258,7 @@ int dbg_entry =3D 0;
>  int dbg_dead =3D 0;
>
>  int fmem_report =3D 0;
> -int fdump_linearize;
> +int fdump_ir;
>  unsigned long long fmemcpy_max_count =3D 100000;
>
>  int preprocess_only;
> @@ -724,12 +724,12 @@ static char **handle_switch_ftabstop(char *arg, cha=
r **next)
>
>  static char **handle_switch_fdump(char *arg, char **next)
>  {
> -       if (!strncmp(arg, "linearize", 9)) {
> -               arg +=3D 9;
> +       if (!strncmp(arg, "ir", 2)) {
> +               arg +=3D 2;
>                 if (*arg =3D=3D '\0')
> -                       fdump_linearize =3D 1;
> +                       fdump_ir =3D 1;
>                 else if (!strcmp(arg, "=3Donly"))
> -                       fdump_linearize =3D 2;
> +                       fdump_ir =3D 2;
>                 else
>                         goto err;
>         }
> diff --git a/lib.h b/lib.h
> index 307ccaeb2..ccac27d0b 100644
> --- a/lib.h
> +++ b/lib.h
> @@ -151,7 +151,7 @@ extern int dbg_entry;
>  extern int dbg_dead;
>
>  extern int fmem_report;
> -extern int fdump_linearize;
> +extern int fdump_ir;
>  extern unsigned long long fmemcpy_max_count;
>
>  extern int arch_m64;
> diff --git a/linearize.c b/linearize.c
> index 6cf97a42e..85acfd9c1 100644
> --- a/linearize.c
> +++ b/linearize.c
> @@ -2262,8 +2262,8 @@ static struct entrypoint *linearize_fn(struct symbo=
l *sym, struct symbol *base_t
>                 add_one_insn(ep, insn);
>         }
>
> -       if (fdump_linearize) {
> -               if (fdump_linearize =3D=3D 2)
> +       if (fdump_ir) {
> +               if (fdump_ir =3D=3D 2)
>                         return ep;
>                 show_entry(ep);
>         }
> diff --git a/sparse.1 b/sparse.1
> index b79c58767..c7ad4483b 100644
> --- a/sparse.1
> +++ b/sparse.1
> @@ -357,7 +357,7 @@ normalized GNU triplet. (e.g. i386-linux-gnu).
>  .
>  .SH DEBUG OPTIONS
>  .TP
> -.B \-fdump-linearize[=3Donly]
> +.B \-fdump-ir[=3Donly]
>  Dump the IR code of a function directly after its linearization,
>  before any simplifications is made. If the argument \fB=3Donly\fR is
>  also given no further processing is done on the function.
> diff --git a/validation/linear/bitfield-init-mask.c b/validation/linear/b=
itfield-init-mask.c
> index 94afa400c..f43605855 100644
> --- a/validation/linear/bitfield-init-mask.c
> +++ b/validation/linear/bitfield-init-mask.c
> @@ -18,7 +18,7 @@ struct bfu bfu_init_20_23(int a)
>
>  /*
>   * check-name: bitfield initializer mask
> - * check-command: test-linearize -fdump-linearize=3Donly -Wno-decl $file
> + * check-command: test-linearize -fdump-ir=3Donly -Wno-decl $file
>   * check-output-ignore
>   *
>   * check-output-contains: and\\..*fffff800\$
> --
> 2.14.0
>
