Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1685D31C57B
	for <linux-sparse@vger.kernel.org>; Fri, 16 Jan 2026 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606194; cv=none; b=jirRpK0qrQHAU++flzxKlmwqNN/iPyImm/7+uxXG+r5LqhtC+PmbciAbPBjO/fKOA/q/kxqXyacj5PBzhoSXbpg33au1L0cFgTMDCA3Of/m1w/z/Y9jPbbVRd6VyoONqYIgow+2a9mbsbEy61gidHGL+Wt94l6s6MWxzulXxKR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606194; c=relaxed/simple;
	bh=27+OCgtPFvChP4VVAqWrBqFH05bQZdNOVemsDw+Jfx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUZOCgdLyzVUqtaQmCMQdYgfCSVmxIJ0SJuP8p72QmvrGIF/STSQviu9JYjaji/ysoBaXB33LY264kTifJyVh1W/lpUENnyD6+gW396Y5yUnBha/LFdOC4Jz3jicMW4tpmtN4JNDasK06rEPbbjpTRs4oruaZDm6r3crA+j6ffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78fb9a67b06so26877217b3.1
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jan 2026 15:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606192; x=1769210992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w8SjSjMVVJWIBW1puKZ6IJpmHQebI8XPDrw3RVvWTKA=;
        b=BN7uVDKX/V1lpGIW6Anqn2dg2VNJcQnjuJlYB3f6PBPg69xpfEW1rhv/VnzkjfvFkF
         DOCT0R7nYGP+RwCfR3YtzWFPi68T55NOvErAzHKfrAmZgbvOBYwvKJvOJTPPE+Z3I0ba
         nvFLB+Ozs70oL5/OXyZXXGylrO4ffCUFazApcO3dFn8/kPUDc825zG6I5rv+IFCZDIZh
         lcyim13JHroD6BYUzkgqzLmZ7JplKIoL/h6HuLG5h3GQezApS2Butpk/Eyo0COTKR0jR
         yzwivuU/UMZI0fDtRJ07VDF9dN8cbiGg7YKX7LTV2BpryWxsWFaU+PQcXxoegosjmE1g
         /X/A==
X-Forwarded-Encrypted: i=1; AJvYcCUVMXUZOZL+emEa1Eie3U4roY+yHhUxCEIENiRdFvV+VNG8nVZ1yUPgwYeD+7rGbAPLyDkDqsQ7JKQ0CAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy247Cn7reDzCboVQ7B76QH90vFRdoCO2ZzcPyYTnbOFXCtJHBO
	0HtcHbjVpZQJmUs/v9EcCGKR8qH559as42COsV7RXd7xpMeloirAGYJ5FgO4ySKRoXLCeMIfj39
	+IivSpNjyxG4VCHo/HKVX4hykjVAZxhXYOsOP+qTPNA==
X-Gm-Gg: AY/fxX4Y3gHenXcfiyfUFV3hfuQz62uiMqSTHY6Wreu9cYnkWxLRqLJekip5n5hH3cD
	mzSLuQrN0dk52pC8q+xaZCGUZSYro12nAzABhFLt/CwiMc/+8qFvA4ZZvwAYCZGmhvmyqzLmMII
	Kp8J86W7jNkXq9nbNMnbcB7C41S84RbZdnaXfgb0KTZ1sHL1doIqHX1+JjqyFW4spCtkHzU3cC9
	ZAF0jdm2LVF6zZmbURtvZwWNGutFYE15jM6W1JmnFmyhK5vPFGfpR1xNWT9Cb+UtvBqI9F4gGrR
	KoU6ymRZf4tbI2Sh0N5MopD++uh46BEcOv4VUZko/CY0/cI9AbnawsMMkA==
X-Received: by 2002:a05:690c:c52c:b0:786:5ebb:4837 with SMTP id
 00721157ae682-793c67f7e92mr32738257b3.33.1768606191904; Fri, 16 Jan 2026
 15:29:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aULJmGi8yib_XH0P@redhat.com>
In-Reply-To: <aULJmGi8yib_XH0P@redhat.com>
From: Chris Li <sparse@chrisli.org>
Date: Fri, 16 Jan 2026 15:29:41 -0800
X-Gm-Features: AZwV_QhcKklISLrbJ7r4opm-5DmLOIRoCiAn4VRjEtJdtlChwuwRHE-mm1SNFWk
Message-ID: <CACePvbW2OybP7P-Vk+pa23SqA0+R0i8=20TiQMq99PvNAYJ8GA@mail.gmail.com>
Subject: Re: [PATCH] sparse/pre-process: introduce "dissect_mode" option to
 fix dissect/semind
To: Oleg Nesterov <oleg@redhat.com>
Cc: Luc Van Oostenryck <lucvoo@kernel.org>, Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

Slowly catching up my back log from the holidays.

On Wed, Dec 17, 2025 at 7:26=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> I don't quite understand why does expand() -> collect_arg() path
> update ->pos for each token in the input *list, but this breaks
> dissect and thus semind.

That is a good question, I don't understand why it did that either. I
did some digging, inside macro argument list expansion, the "#include
" is not allowed. It is not possible to switch streams here. The
"pos.pos" is for human consumption anyway, it has no effect on the IR
generation. The only visible effect as far as I can tell is related to
the preprocessor "-E" in lib.c:

        if (preprocess_only) {
                while (!eof_token(token)) {
                        int prec =3D 1;
                        struct token *next =3D token->next;
                        const char *separator =3D "";
                        if (next->pos.whitespace)
                                separator =3D " ";
                        if (next->pos.newline) {
                                separator =3D "\n\t\t\t\t\t";
                                prec =3D next->pos.pos; <--- use pos as
indentation level.
                                if (prec > 4)
                                        prec =3D 4;
                        }
                        printf("%s%.*s", show_token(token), prec, separator=
);
                        token =3D next;

The "-E" output has some indentation enhancement to turn space into
tab level indentation. This "pos" assignment tries to align the
indentation context of the input arguments to the same level of the
expanding macro name.

> Test-case:
>
>         $ cat -n PP_POS.c
>              1  #define READ_ONCE(x) x
>              2  #define WRITE_ONCE(x, y) x =3D y
>              3
>              4  int R, W;
>              5
>              6  void func(void)
>              7  {
>              8    WRITE_ONCE(
>              9       W,

With your patch, when doing "-E", the W will get indentation deeper
than WRITE_ONCE.

>             10       READ_ONCE(R)
>             11    );
>             12  }
>
>         $ ./test-dissect PP_POS.c
>            4:5                    def   v R                              =
  int
>            4:8                    def   v W                              =
  int
>            6:6                    def   f func                           =
  void ( ... )
>            8:3   func             -w-   v W                              =
  int
>            8:3   func             -r-   v R                              =
  int
>
> The reported positions of the usage of R and W are wrong,
> and thus ./semind doesn't work:

It seems to me this enhancement can be used on other macro related
expansions as well.

>
>         $ ./semind add PP_POS.c
>         $ ./semind search -l PP_POS.c:10:16
>
> With this patch:
>
>         $ ./test-dissect PP_POS.c
>            4:5                    def   v R                              =
  int
>            4:8                    def   v W                              =
  int
>            6:6                    def   f func                           =
  void ( ... )
>            9:6   func             -w-   v W                              =
  int
>           10:16  func             -r-   v R                              =
  int
>
>         $ ./semind add PP_POS.c
>         $ ./semind search -l PP_POS.c:10:16
>         (def) PP_POS.c  4       5               int R, W;
>         (-r-) PP_POS.c  10      16      func    READ_ONCE(R)
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  dissect.c     | 1 +
>  options.c     | 1 +
>  options.h     | 1 +
>  pre-process.c | 8 +++++---
>  4 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/dissect.c b/dissect.c
> index a6003afa..5fed8e22 100644
> --- a/dissect.c
> +++ b/dissect.c
> @@ -714,6 +714,7 @@ end:
>
>  void dissect(struct reporter *rep, struct string_list *filelist)
>  {
> +       dissect_mode =3D 1;

I don't think we need dissect_mode. I am leaning towards enabling it
all the time, maybe except for the preprocessor only mode.

>         reporter =3D rep;
>
>         DO_LIST(filelist, file, do_file(file));
> diff --git a/options.c b/options.c
> index 6ee4d878..0f207e80 100644
> --- a/options.c
> +++ b/options.c
> @@ -71,6 +71,7 @@ int dump_macro_defs =3D 0;
>  int dump_macros_only =3D 0;
>
>  int dissect_show_all_symbols =3D 0;
> +int dissect_mode =3D 0;
>
>  unsigned long fdump_ir;
>  int fhosted =3D 1;
> diff --git a/options.h b/options.h
> index c2a9551a..b559254d 100644
> --- a/options.h
> +++ b/options.h
> @@ -71,6 +71,7 @@ extern int dump_macro_defs;
>  extern int dump_macros_only;
>
>  extern int dissect_show_all_symbols;
> +extern int dissect_mode;
>
>  extern unsigned long fdump_ir;
>  extern int fhosted;
> diff --git a/pre-process.c b/pre-process.c
> index 3fb25082..64445881 100644
> --- a/pre-process.c
> +++ b/pre-process.c
> @@ -294,9 +294,11 @@ static struct token *collect_arg(struct token *prev,=
 int vararg, struct position
>                 } else if (match_op(next, ',') && !nesting && !vararg) {
>                         break;
>                 }
> -               next->pos.stream =3D pos->stream;
> -               next->pos.line =3D pos->line;
> -               next->pos.pos =3D pos->pos;
> +               if (!dissect_mode) {
> +                       next->pos.stream =3D pos->stream;
> +                       next->pos.line =3D pos->line;
> +                       next->pos.pos =3D pos->pos;
> +               }

Maybe change it to "if (preprocess_only)", and fix all the validation
error output of the checker. What do you say?

Overall I feel that without this position overwrite is better to
locate the real location of the argument of the macro. If anyone knows
another reason we should do the position overwrite, please let me
know.

Alternatively we can also fix the preprocessor "-E" indentation
output. Might not be worth the complexity.

Chris

>                 next->pos.newline =3D 0;
>                 p =3D &next->next;
>         }
> --
> 2.52.0
>
>
