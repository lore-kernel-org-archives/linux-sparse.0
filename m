From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2] sparse: Make -Werror turn warnigns into errors
Date: Thu, 09 Oct 2014 01:56:04 +0100
Message-ID: <5435DD24.3070005@ramsay1.demon.co.uk>
References: <795aaa7448d91bd59bcbea3d8e49b068a569409e.1411632579.git.tgraf@suug.ch>	<20141007094508.GN23154@mwanda>	<20141008093910.GB3181@casper.infradead.org> <CANeU7Q=0VhRqKQqO0nKzUT3vN8AU6bcTMC6QKAm3H-Y2i-+4hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:41983 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751370AbaJIA4K (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 8 Oct 2014 20:56:10 -0400
In-Reply-To: <CANeU7Q=0VhRqKQqO0nKzUT3vN8AU6bcTMC6QKAm3H-Y2i-+4hA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Thomas Graf <tgraf@suug.ch>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 08/10/14 18:51, Christopher Li wrote:
> On Wed, Oct 8, 2014 at 5:39 PM, Thomas Graf <tgraf@suug.ch> wrote:
>>> This just enables -Werror for everyone so now I can't run Sparse on
>>> itself now because there are old errors from 2007.
>>
>> The above change should merely have sparse fail upon an error and not
>> warnings unless you specifiy -Werror which I would consider expected
>> behaviour.
> 
> Actually I realized that this "-Werror" patch is wrong. As it is, we can't
> actually make the full kernel check without hitting sparse errors interrupting
> the build. That is pretty unacceptable.
> 
> We should reserve the "-Werror" for gcc. It means gcc should treat warning
> as error. We should have another option like "-Wsparse-error" for telling sparse
> to treat warning as error. Just like "-Wall" does not mean sparse should
> turn on all usual warnings. We have "-Wsparse-all" for that.
> 
> I have the following patch renaming the option. BTW, I think sparse
> should only return error when "-Wsparse-error" was given.
> 
> Any feed back?

I haven't been following this discussion, but I would have
expected to see a check for '-Wsparse-error' in the 
'check_only_option' function in cgcc as part of this patch.

HTH

ATB,
Ramsay Jones


> Chris
> 
> diff --git a/lib.c b/lib.c
> index 8395662..b1b18aa 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -150,7 +150,7 @@ void warning(struct position pos, const char * fmt, ...)
>  {
>         va_list args;
> 
> -       if (Werror) {
> +       if (Wsparse_error) {
>                 va_start(args, fmt);
>                 do_error(pos, fmt, args);
>                 va_end(args);
> @@ -226,7 +226,7 @@ int Wdesignated_init = 1;
>  int Wdo_while = 0;
>  int Winit_cstring = 0;
>  int Wenum_mismatch = 1;
> -int Werror = 0;
> +int Wsparse_error = 0;
>  int Wnon_pointer_null = 1;
>  int Wold_initializer = 1;
>  int Wone_bit_signed_bitfield = 1;
> @@ -439,7 +439,7 @@ static const struct warning {
>         { "designated-init", &Wdesignated_init },
>         { "do-while", &Wdo_while },
>         { "enum-mismatch", &Wenum_mismatch },
> -       { "error", &Werror },
> +       { "sparse-error", &Wsparse_error },
>         { "init-cstring", &Winit_cstring },
>         { "non-pointer-null", &Wnon_pointer_null },
>         { "old-initializer", &Wold_initializer },
> @@ -471,7 +471,7 @@ static char **handle_onoff_switch(char *arg, char **next, co
> 
>         if (!strcmp(p, "sparse-all")) {
>                 for (i = 0; i < n; i++) {
> -                       if (*warnings[i].flag != WARNING_FORCE_OFF && warnings[i
> +                       if (*warnings[i].flag != WARNING_FORCE_OFF && warnings[i
>                                 *warnings[i].flag = WARNING_ON;
>                 }
>              }
> diff --git a/lib.h b/lib.h
> index dc01684..15b69fa 100644
> --- a/lib.h
> +++ b/lib.h
> @@ -112,7 +112,7 @@ extern int Wdefault_bitfield_sign;
>  extern int Wdesignated_init;
>  extern int Wdo_while;
>  extern int Wenum_mismatch;
> -extern int Werror;
> +extern int Wsparse_error;
>  extern int Winit_cstring;
>  extern int Wnon_pointer_null;
>  extern int Wold_initializer;
> diff --git a/sparse.1 b/sparse.1
> index acdce53..63fceb9 100644
> --- a/sparse.1
> +++ b/sparse.1
> @@ -24,7 +24,7 @@ off those warnings, pass the negation of the associated warnin
>  Turn on all sparse warnings, except for those explicitly disabled via
>  \fB\-Wno\-something\fR.
>  .TP
> -.B \-Werror
> +.B \-Wsparse\-error
>  Turn all sparse warnings into errors.
>  .TP
>  .B \-Waddress\-space
> diff --git a/sparse.c b/sparse.c
> index 7d389b1..6b3324c 100644
> --- a/sparse.c
> +++ b/sparse.c
> @@ -288,7 +288,7 @@ static void check_symbols(struct symbol_list *list)
>                 }
>         } END_FOR_EACH_PTR(sym);
> 
> -       if (die_if_error)
> +       if (Wsparse_error && die_if_error)
>                 exit(1);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> .
> 

