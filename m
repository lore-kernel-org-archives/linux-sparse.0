Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDEC10F1
	for <linux-sparse@vger.kernel.org>; Mon,  1 Dec 2025 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764618765; cv=none; b=uxv7025+F/LtLH+LPxPwuaWObCoM6KjlDcDwLP4Y/cvG92PZ3JY8Z0vEwAhaVWJxKPWBAoZe5+p9zLeISgyKeRV4a7MkCMNt1qID0wkeGA/1mHYexcZCjyFxRTUkyLV2cpIoVC4dfThNHqoNVN8y5HsZDYVfBFryHrHundPP8VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764618765; c=relaxed/simple;
	bh=I1NoU67bW3Ymn//IrDnLtg5wsW8pf3qTsSGKet8AqN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/3+HIfFpyINBpf/RmyDM7AXUCCLPXlbK5kvCH9ExiKJUpDt/fEeluqBL6Wr3S0sDmK9vHn4hUx39/06hdfpb8frEM2RjqeHvNX3ZP3HivDx7l1vYkQOmf3o1QHKGtwpZ8i7EpIfsCdZFSL983DhVGOJFzIs8EyFUFGA6p75XzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f97ab5cfcso3716054d50.0
        for <linux-sparse@vger.kernel.org>; Mon, 01 Dec 2025 11:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764618761; x=1765223561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EYos7fpW7FJL/RmLrjc3EmY9G4BKG5bZy9eugXsvX+k=;
        b=Zhvl2oG6B4OdlOxT2/dBhUPZFeygfTpECOYpGQoaF+italyd9p21kr7swDwl742LZI
         Yh6UMxkhVdz/KFwevCIWtR1c7N/mEl2zyD9K/0Z0YzdcXLW+dDLe8l2F6aTr5RBwSv9A
         Rn/sV0Cwc59ck1q5u/iHmGlVIRVYhfEj4X083ytppoOT61KUU+xDnhIG/JnUdWMNEtf0
         u43vLisaBswdl975dTK1kXmP0NQgGKBl1MSM0Y5ks9YsYqCPyz1LTK5z0iCH/JbVA99x
         w+6cILtD3odTKvtq+HtJGvT36oP/QYx1O0TwGKMe5RDcvenMBF1w6NRk7rsBOeFcjUlx
         dHtg==
X-Gm-Message-State: AOJu0YxXMIkkcrVtSmSPhm+7iko6OneVrd0Xq3rX57sI9YswLsG4AIP8
	SLWm/xQU7XnyTzWYI8eP8xImEk3IDR1g7HvP5KRDcXHOZwdXojGbjlyRnkBXYT2Rs64y35BY5TY
	DVkrXoYfwB+MEzwG2lNtht/sqhT3LL8f5/YX9BA7tjw==
X-Gm-Gg: ASbGncuwX+Wzu5VhLl4DCB7Bl41VGnYGEhCDhxd5LUBnODAaXr6au21wsXuer6LCiqM
	nyw6eu7biAQ1qoMnkxTVhJza3s4d0mlFEkkUjBk3JuPMjmdJHZA9ALjFcWdDSSd+3Kg56jmlvGS
	ogBKVLE0Y0WVZeDNHajzUmJR+xLN/ZohOmCRdFRsEwdxUzmX6aHGMrS5oDW2B5s1QlhUHXqoFm0
	9nMWNIvOC9Bd7h8oxfBX4Y+vPyc0DmIH6ZnCIEUhA2vxzdkUDZDmdZZ1BG4Paa9QUHStH1quKB4
	IVMSujMT+8/OsgpbdiSei0p+iSLm
X-Google-Smtp-Source: AGHT+IFSGuxjBrRNZeQpGSY2mYei1FJySnUQ6mm8MtmCJ7XKLmI5XjToAVbfNWCnOdN+Tml+pCnxuyKdNtmPhUt8lII=
X-Received: by 2002:a05:690e:251b:10b0:641:718:8a0d with SMTP id
 956f58d0204a3-643293cbe6bmr15303852d50.65.1764618761098; Mon, 01 Dec 2025
 11:52:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020153918.812235-1-ben.dooks@codethink.co.uk> <20251020153918.812235-4-ben.dooks@codethink.co.uk>
In-Reply-To: <20251020153918.812235-4-ben.dooks@codethink.co.uk>
From: Chris Li <sparse@chrisli.org>
Date: Mon, 1 Dec 2025 23:52:30 +0400
X-Gm-Features: AWmQ_blXFdyNVB9vkAjRBTvoVfOiwXvYnP1eTGCB-k7D7NG80y_rd5ZKvvlrT5w
Message-ID: <CACePvbU9ME8b0Qvd4c5sekMKFmhHgJWG2fvWxVMXhsMgYEzBgw@mail.gmail.com>
Subject: Re: [PATCH RESEND2 3/4] evaluate: check variadic argument types
 against formatting info
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-sparse@vger.kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 7:39=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.u=
k> wrote:
>
> The variadic argumebt code did not check any of the variadic arguments
> as it did not previously know the possible type. Now we have the possible
> formatting information stored in the ctype, we can do some checks on the
> printf formatting types.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  Makefile        |   1 +
>  builtin.c       |   4 +-
>  evaluate.c      |  14 +-
>  evaluate.h      |  10 +-
>  verify-format.c | 504 ++++++++++++++++++++++++++++++++++++++++++++++++
>  verify-format.h |   6 +
>  6 files changed, 532 insertions(+), 7 deletions(-)
>  create mode 100644 verify-format.c
>  create mode 100644 verify-format.h
>
> diff --git a/Makefile b/Makefile
> index e172758b..670e95aa 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -90,6 +90,7 @@ LIB_OBJS +=3D tokenize.o
>  LIB_OBJS +=3D unssa.o
>  LIB_OBJS +=3D utils.o
>  LIB_OBJS +=3D version.o
> +LIB_OBJS +=3D verify-format.o
>
>  PROGRAMS :=3D
>  PROGRAMS +=3D compile
> diff --git a/builtin.c b/builtin.c
> index 3a29c3ae..e4751445 100644
> --- a/builtin.c
> +++ b/builtin.c
> @@ -438,7 +438,7 @@ static int evaluate_generic_int_op(struct expression =
*expr)
>                 NEXT_PTR_LIST(t);
>         } END_FOR_EACH_PTR(arg);
>         FINISH_PTR_LIST(t);
> -       return evaluate_arguments(types, expr->args);
> +       return evaluate_arguments(NULL, types, expr->args);
>
>  err:
>         sparse_error(arg->pos, "non-integer type for argument %d:", n);
> @@ -502,7 +502,7 @@ static int eval_atomic_common(struct expression *expr=
)
>
>         if (!expr->ctype)       // set the return type, if needed
>                 expr->ctype =3D ctype;
> -       return evaluate_arguments(types, expr->args);
> +       return evaluate_arguments(NULL, types, expr->args);
>
>  err:
>         sparse_error(arg->pos, "invalid type for argument %d:", n);
> diff --git a/evaluate.c b/evaluate.c
> index fe716f63..4ffbba73 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -42,6 +42,7 @@
>  #include "symbol.h"
>  #include "target.h"
>  #include "expression.h"
> +#include "verify-format.h"
>
>  struct symbol *current_fn;
>
> @@ -1386,8 +1387,8 @@ static int whitelist_pointers(struct symbol *t1, st=
ruct symbol *t2)
>         return !Wtypesign;
>  }
>
> -static int check_assignment_types(struct symbol *target, struct expressi=
on **rp,
> -       const char **typediff)
> +int check_assignment_types(struct symbol *target, struct expression **rp=
,
> +                          const char **typediff)
>  {
>         struct symbol *source =3D degenerate(*rp);
>         struct symbol *t, *s;
> @@ -2324,7 +2325,8 @@ static struct symbol *evaluate_alignof(struct expre=
ssion *expr)
>         return size_t_ctype;
>  }
>
> -int evaluate_arguments(struct symbol_list *argtypes, struct expression_l=
ist *head)
> +int evaluate_arguments(struct symbol *fn, struct symbol_list *argtypes,
> +                      struct expression_list *head)
>  {
>         struct expression *expr;
>         struct symbol *argtype;
> @@ -2365,6 +2367,10 @@ int evaluate_arguments(struct symbol_list *argtype=
s, struct expression_list *hea
>                 NEXT_PTR_LIST(argtype);
>         } END_FOR_EACH_PTR(expr);
>         FINISH_PTR_LIST(argtype);
> +
> +       if (fn && Wformat)
> +               verify_format_attribute(fn, head);
> +
>         return 1;
>  }
>
> @@ -3191,7 +3197,7 @@ static struct symbol *evaluate_call(struct expressi=
on *expr)
>                 if (!sym->op->args(expr))
>                         return NULL;
>         } else {
> -               if (!evaluate_arguments(ctype->arguments, arglist))
> +               if (!evaluate_arguments(ctype, ctype->arguments, arglist)=
)
>                         return NULL;
>                 args =3D expression_list_size(expr->args);
>                 fnargs =3D symbol_list_size(ctype->arguments);
> diff --git a/evaluate.h b/evaluate.h
> index a16e9703..3f51129d 100644
> --- a/evaluate.h
> +++ b/evaluate.h
> @@ -28,8 +28,16 @@ void evaluate_symbol_list(struct symbol_list *list);
>
>  ///
>  // evaluate the arguments of a function
> +// @fn: the symbol of the prototype
>  // @argtypes: the list of the types in the prototype
>  // @args: the list of the effective arguments
> -int evaluate_arguments(struct symbol_list *argtypes, struct expression_l=
ist *args);
> +int evaluate_arguments(struct symbol *fn, struct symbol_list *argtypes, =
struct expression_list *args);
>
> +///
> +// check if assignment types are compatible
> +// @target: the target assignment
> +// @rp: the expression
> +// @typediff: the resulant message if different type
> +int check_assignment_types(struct symbol *target, struct expression **rp=
,
> +                          const char **typediff);
>  #endif
> diff --git a/verify-format.c b/verify-format.c
> new file mode 100644
> index 00000000..979729bf
> --- /dev/null
> +++ b/verify-format.c
> @@ -0,0 +1,504 @@
> +/*
> + * sparse/verify-format.c
> + *
> + * Copyright (C) 2019 Codethink Ltd.
> + *     Written by Ben Dooks <ben.dooks@codethink.co.uk>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHE=
R
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + *
> + * Verification code for format-attributes (currently printf)
> + */
> +#include <stdlib.h>
> +#include <stdarg.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <ctype.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +
> +#include "evaluate.h"
> +#include "lib.h"
> +#include "allocate.h"
> +#include "parse.h"
> +#include "token.h"
> +#include "symbol.h"
> +#include "target.h"
> +#include "expression.h"
> +#include "verify-format.h"
> +
> +struct format_type {
> +       const char      *format;
> +       int             (*test)(struct format_type *fmt,
> +                               struct expression **expr,
> +                               struct symbol *ctype,
> +                               struct symbol **target,
> +                               const char **typediff);
> +       struct symbol   *data;
> +};
> +
> +struct format_state {
> +       struct expression       *expr;
> +       unsigned int            first;
> +       unsigned int            fmt_index;
> +       unsigned int            arg_index;
> +       unsigned int            used_position: 1;
> +};
> +
> +static int printf_fmt_numtype(struct format_type *fmt,
> +                             struct expression **expr,
> +                             struct symbol *ctype,
> +                             struct symbol **target, const char **typedi=
ff)
> +{
> +       struct symbol *type =3D fmt->data;
> +       *target =3D type;
> +       return check_assignment_types(*target, expr, typediff);
> +}
> +
> +static int printf_fmt_string(struct format_type *fmt,
> +                            struct expression **expr,
> +                            struct symbol *ctype,
> +                            struct symbol **target, const char **typedif=
f)
> +{
> +       *target =3D &const_string_ctype;
> +       return check_assignment_types(*target, expr, typediff);
> +}
> +
> +static int printf_fmt_pointer(struct format_type *fmt,
> +                             struct expression **expr,
> +                             struct symbol *ctype,
> +                             struct symbol **target, const char **typedi=
ff)
> +{
> +       *target =3D &const_ptr_ctype;
> +       return check_assignment_types(*target, expr, typediff);

It seems this and the above two functions are redoing the same thing
with different *target values.
You might consider having a helper function accept the new target type
as input argument then assign it to *target and call
check_assignment_types(). Or move that logic to
check_assignment_type(), let it accept the new target_type.

Chris
> +}
> +
> +static int printf_fmt_print_pointer(struct format_type *fmt,
> +                                   struct expression **expr,
> +                                   struct symbol *ctype,
> +                                   struct symbol **target,
> +                                   const char **typediff)
> +{
> +       int ret;
> +       *target =3D &const_ptr_ctype;
> +       ret =3D check_assignment_types(*target, expr, typediff);
> +       if (ret =3D=3D 0) {
> +               /* if just printing, ignore address-space mismatches */
> +               if (strcmp(*typediff, "different address spaces") =3D=3D =
0)
> +                       ret =3D 1;
> +       }
> +       return ret;
> +}
> +
> +static struct format_type printf_fmt_ptr_ref =3D {
> +       .format =3D "p",
> +       .test =3D printf_fmt_pointer,
> +};
> +
> +static struct expression *get_nth_expression(struct expression_list *arg=
s, int nr)
> +{
> +       return ptr_list_nth_entry((struct ptr_list *)args, nr);
> +}
> +
> +static int is_float_spec(char t)
> +{
> +       return t =3D=3D 'f' || t =3D=3D 'g' || t =3D=3D 'F' || t =3D=3D '=
G';
> +}
> +
> +static struct format_type *parse_printf_get_fmt(struct format_type *type=
,
> +                                               const char *msg,
> +                                               const char **msgout)
> +{
> +       const char *ptr =3D msg;
> +       int szmod=3D0;
> +
> +       type->test =3D NULL;
> +       *msgout =3D ptr;
> +
> +       if (*ptr =3D=3D 's') {
> +               ptr++;
> +               type->test =3D printf_fmt_string;
> +       } else if (*ptr =3D=3D 'c') {
> +               ptr++;
> +               type->test =3D printf_fmt_numtype;
> +               type->data =3D &char_ctype;
> +       } else if (*ptr =3D=3D 'p') {
This function has very deep nesting "else". If we can flatten the
indentation and make it use less nested "else" will help the
readability.

You can take a look at the linux kernel lib/vsprintf.c for
inspiration. Code structure wise it is doing a similar thing,
https://codebrowser.dev/linux/linux/lib/vsprintf.c.html#vsnprintf

Their vsnprintf  there is using much less 'else' statements.

> +               ptr++;
> +               type->test =3D printf_fmt_print_pointer;
> +               /* check for pointer being printed as hex explicitly */
> +               if (*ptr =3D=3D 'x' || *ptr =3D=3D 'X') {
> +                       ptr++;
> +               } else if (isalpha(*ptr)) {
> +                       /* probably some extra specifiers after %p */
> +                       ptr++;
> +                       type->test =3D printf_fmt_pointer;
> +               }
> +       } else if (*ptr =3D=3D 'z') {
> +               // todo - we should construct pointer to int/etc //
> +
> +               ptr++;
> +               if (*ptr =3D=3D 'd' || *ptr =3D=3D 'i') {
> +                       ptr++;
> +                       type->test =3D printf_fmt_numtype;
> +                       type->data =3D ssize_t_ctype;
> +               } else if (*ptr =3D=3D 'u' || *ptr =3D=3D 'x' || *ptr =3D=
=3D 'X' ||
> +                          *ptr =3D=3D 'o') {
> +                       ptr++;
> +                       type->test =3D printf_fmt_numtype;
> +                       type->data =3D size_t_ctype;
> +               }
> +       } else {
> +               if (*ptr =3D=3D 'l') {
> +                       szmod++;
> +                       ptr++;
> +                       if (*ptr =3D=3D 'l') {
> +                               szmod++;
> +                               ptr++;
> +                       }
> +               } else {
> +                       if (*ptr =3D=3D 'h') { // short/char to int
> +                               szmod =3D -1;
> +                               ptr++;
> +                               if (*ptr =3D=3D 'h')  // promotion from c=
har
> +                                       ptr++;
> +                       }
> +                       if (*ptr =3D=3D 't') {  // ptrdiff_t
> +                               szmod =3D 2;
> +                               ptr++;
> +                       }
> +                       if (*ptr =3D=3D 'j') { // intmax_t
> +                               szmod =3D 3;
> +                               ptr++;
> +                       }
> +               }
> +
> +               if (*ptr =3D=3D 'x' || *ptr =3D=3D 'X' || *ptr =3D=3D 'u'=
 || *ptr =3D=3D 'o') {
> +                       ptr++;
> +                       type->test =3D printf_fmt_numtype;
> +                       switch (szmod) {
> +                       case -1:
> +                               type->data =3D &ushort_ctype;
> +                               break;
> +                       case 0:
> +                               type->data =3D &uint_ctype;
> +                               break;
> +                       case 1:
> +                               type->data =3D &ulong_ctype;
> +                               break;
> +                       case 2:
> +                               type->data =3D &ullong_ctype;
> +                               break;
> +                       case 3:
> +                               type->data =3D uintmax_ctype;
> +                               break;
> +                       default:
> +                               type->test =3D NULL;
> +                       }
> +               } else if (*ptr =3D=3D 'i' || *ptr =3D=3D 'd') {
> +                       ptr++;
> +                       type->test =3D printf_fmt_numtype;
> +                       switch (szmod) {
> +                       case -1:
> +                               type->data =3D &short_ctype;
> +                               break;
> +                       case 0:
> +                               type->data =3D &int_ctype;
> +                               break;
> +                       case 1:
> +                               type->data =3D &long_ctype;
> +                               break;
> +                       case 2:
> +                               type->data =3D &llong_ctype;
> +                               break;
> +                       case 3:
> +                               type->data =3D intmax_ctype;
> +                               break;
> +                       default:
> +                               type->test =3D NULL;
> +                       }
> +               } else if (*ptr =3D=3D 'L' && is_float_spec(ptr[1])) {
> +                       type->test =3D printf_fmt_numtype;
> +                       type->data =3D &ldouble_ctype;
> +                       ptr +=3D 2;
> +               } else if (is_float_spec(*ptr)) {
> +                       type->test =3D printf_fmt_numtype;
> +                       type->data =3D szmod =3D=3D 1 ? &ldouble_ctype : =
 &double_ctype;
> +                       ptr++;
> +               } else if (*ptr =3D=3D 'n') {
> +                       /* pointer to an de-referenced int/etc */
> +
> +                       /* todo - we should construct pointer to int/etc
> +                        * also should not have any flags or widths for t=
his
> +                        */
> +                       type->test =3D printf_fmt_pointer;
> +                       ptr++;
> +               }
> +       }
> +
> +       if (type->test =3D=3D NULL)
> +               return NULL;
> +
> +       *msgout =3D ptr;
> +       return type;
> +}
> +
> +static int is_printf_flag(char ch)
> +{
> +       return ch =3D=3D '0' || ch =3D=3D '+' || ch =3D=3D '-' || ch =3D=
=3D ' ' || ch =3D=3D '#';
> +}
> +
> +static int printf_check_position(const char **fmt)
> +{
> +       const char *ptr=3D *fmt;
> +
> +       if (!isdigit(*ptr))
> +               return -1;
> +       while (isdigit(*ptr))
> +               ptr++;
> +       if (*ptr =3D=3D '$') {
> +               const char *pos =3D *fmt;
> +               *fmt =3D ptr+1;
> +               return strtoul(pos, NULL, 10);
> +       }
> +       return -1;
> +}
> +
> +static void parse_format_printf_checkpos(struct format_state *state,
> +                                        const char *which)
> +{
> +       if (state->used_position) {
> +               warning(state->expr->pos,
> +                       "format %d: %s: no position specified",
> +                       state->arg_index-1, which);
> +       }
> +}
> +
> +static int parse_format_printf_argfield(const char **fmtptr,
> +                                       struct format_state *state,
> +                                       struct expression_list *args,
> +                                       int *pos, const char *which)
> +{
> +       struct expression *expr;
> +       struct symbol *ctype;
> +       const char *fmt =3D *fmtptr;
> +       int argpos =3D -1;
> +
> +       /* check for simple digit-string width/precision specifier first =
*/
> +       if (*fmt !=3D '*') {
> +               while (isdigit(*fmt))
> +                       fmt++;
> +               *fmtptr =3D fmt;
> +               return 0;
> +       }
> +
> +       fmt++;
> +       argpos =3D printf_check_position(&fmt);
> +
> +       if (argpos > 0) {
> +               argpos +=3D state->first - 1;
> +               state->used_position =3D 1;
> +       } else {
> +               argpos =3D (*pos)++;
> +               state->arg_index++;
> +               parse_format_printf_checkpos(state, which);
> +       }
> +
> +       *fmtptr =3D fmt;
> +       expr =3D get_nth_expression(args, argpos-1);
> +       if (!expr) {
> +               warning(state->expr->pos, "%s: no argument at position %d=
",
> +                       which, argpos);
> +               return 1;
> +       }
> +
> +       /* check the value we got was int/uint type */
> +       ctype =3D expr->ctype;
> +       if (ctype) {
> +               struct symbol *target =3D &int_ctype;
> +
> +               if (ctype !=3D &int_ctype && ctype !=3D &uint_ctype) {
> +                       warning(expr->pos, "incorrect type for %s argumen=
t %d", which, argpos);
> +                       info(expr->pos, "   expected %s", show_typename(t=
arget));
> +                       info(expr->pos, "   got %s", show_typename(ctype)=
);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * printf format parsing code
> + *
> + * this code currently does not:
> + * - check castable types (such as int vs long vs long long)
> + * - validate all arguments specified are also used...
> + */
> +static int parse_format_printf(const char **fmtstring,
> +                              struct format_state *state,
> +                              struct expression_list *args)
> +{
> +       struct format_type ftype;       /* temp storage for format info *=
/
> +       struct format_type *type;       /* type found from the parse */
> +       struct expression *expr;
> +       const char *fmt =3D *fmtstring;   /* pointer to parse position */
> +       const char *fmtpost =3D NULL;     /* moved to end of the parsed f=
ormat */
> +       int pos =3D state->arg_index;     /* position of the argument */
> +       int error =3D 0;
> +       int ret;
> +
> +       if (!fmt) {
> +               warning(state->expr->pos, "no format string passed");
> +               return -1;
> +       }
> +
> +       /* trivial check for %% */
> +       fmt++;
> +       if (fmt[0] =3D=3D '%') {
> +               *fmtstring =3D fmt+1;
> +               return 0;
> +       }
> +
> +       state->arg_index++;
> +       state->fmt_index++;
> +
> +       ret =3D printf_check_position(&fmt);
> +       if (ret =3D=3D 0) {
> +               /* we got an invalid position argument */
> +               error++;
> +       } else if (ret < 0) {
> +               parse_format_printf_checkpos(state, "position");
> +       } else {
> +               state->used_position =3D 1;
> +               pos =3D ret + state->first - 1;
> +       }
> +
> +       /* get rid of any formatting flag bits */
> +       while (is_printf_flag(*fmt))
> +               fmt++;
> +
> +       /* now there is the posibility of a width specifier */
> +       if (parse_format_printf_argfield(&fmt, state, args, &pos, "width"=
))
> +               error++;
> +
> +       /* now we might have the precision specifier */
> +       if (*fmt =3D=3D '.') {
> +               fmt++;
> +               if (parse_format_printf_argfield(&fmt, state, args, &pos,=
 "position"))
> +                       error++;
> +       }
> +
> +       type =3D parse_printf_get_fmt(&ftype, fmt, &fmtpost);
> +
> +       if (!type && fmt[0] =3D=3D 'p')
> +               type =3D &printf_fmt_ptr_ref;     /* probably some extens=
ion */
> +
> +       if (type) {
> +               struct symbol *ctype, *target =3D NULL;
> +               const char *typediff =3D "different types";
> +               int ret;
> +
> +               *fmtstring =3D fmtpost;
> +               expr =3D get_nth_expression(args, pos-1);
> +               if (!expr) {
> +                       /* no argument, but otherwise valid argument stri=
ng */
> +                       warning(state->expr->pos, "no argument at positio=
n '%d'", pos);
> +                       return 0;
> +               }
> +
> +               ctype =3D expr->ctype;
> +               if (!ctype)
> +                       return -3;
> +
> +               ret =3D type->test(type, &expr, ctype, &target, &typediff=
);
> +               if (!target)    /* shouldn't happen, but catch anyway */
> +                       return -4;
> +
> +               if (ret =3D=3D 0) {
> +                       warning(expr->pos, "incorrect type in argument %d=
 (%s)", pos, typediff);
> +                       info(expr->pos, "   expected %s", show_typename(t=
arget));
> +                       info(expr->pos, "   got %s", show_typename(ctype)=
);
> +               }
> +       } else {

I think this function can use some tricks to flatten it a bit as well.

Chris
> +               /* try and find the end of this format string by looking =
for a space*/
> +               fmtpost =3D *fmtstring;
> +               while (*fmtpost > ' ')
> +                       fmtpost++;
> +               warning(state->expr->pos, "cannot evaluate type '%.*s'",
> +                       (int)(fmtpost - *fmtstring), *fmtstring);
> +               *fmtstring +=3D 1;
> +               return -1;
> +       }
> +
> +       return 1;
> +}
> +
> +/*
> + * attempt to run through a printf format string and work out the types
> + * it specifies. The format is parsed from the __attribute__(format())
> + * in the parser code which stores the positions of the message and arg
> + * start in the ctype.
> + */
> +void verify_format_attribute(struct symbol *fn, struct expression_list *=
args)
> +{
> +       struct format_state state =3D { };
> +       struct expression *expr;
> +       struct expression *init;
> +       const char *fmt_string;
> +
> +       if (!fn->ctype.format.index)
> +               return;
> +
> +       expr =3D get_nth_expression(args, fn->ctype.format.index-1);
> +       if (!expr)
> +               return;
> +
> +       if (expr->type !=3D EXPR_SYMBOL || expr->symbol->ident)
> +               return;                 // not a literal
> +       init =3D expr->symbol->initializer;
> +       if (!init || init->type !=3D EXPR_STRING)
> +               return;                 // not a string
> +       fmt_string =3D init->string->data;
> +
> +       state.expr =3D expr;
> +       state.first =3D fn->ctype.format.first;
> +       state.arg_index =3D fn->ctype.format.first;
> +
> +       if (!fmt_string) {
> +               warning(expr->pos, "not a format string?");
> +       } else {
> +               const char *string =3D fmt_string;
> +               int fail =3D 0;
> +
> +               while (string[0]) {
> +                       if (string[0] !=3D '%') {
> +                               /* strip anything before the '%' */
> +                               string++;
> +                               continue;
> +                       }
> +
> +                       if (parse_format_printf(&string, &state, args) < =
0)
> +                               fail++;
> +               }
> +
> +               if (fail > 0)
> +                       /* format string may have '\n' etc embedded in it=
 */
> +                       warning(expr->pos, "cannot evaluate format string=
");
> +       }
> +}
> diff --git a/verify-format.h b/verify-format.h
> new file mode 100644
> index 00000000..4a7ef79d
> --- /dev/null
> +++ b/verify-format.h
> @@ -0,0 +1,6 @@
> +#ifndef VERIFY_FORMAT_H
> +#define VERIFY_FORMAT_H
> +
> +void verify_format_attribute(struct symbol *fn, struct expression_list *=
args);
> +
> +#endif
> --
> 2.37.2.352.g3c44437643
>
