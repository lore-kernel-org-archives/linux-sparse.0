From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: Add GCC pre-defined macros for user-space
Date: Sat, 15 Aug 2009 12:36:37 -0700
Message-ID: <70318cbf0908151236q2c691d73n5114ab21f3cbd819@mail.gmail.com>
References: <1250348235-19691-1-git-send-email-penberg@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f172.google.com ([209.85.212.172]:43436 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbZHOTgh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 15 Aug 2009 15:36:37 -0400
Received: by vws2 with SMTP id 2so1864178vws.4
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2009 12:36:38 -0700 (PDT)
In-Reply-To: <1250348235-19691-1-git-send-email-penberg@cs.helsinki.fi>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-sparse@vger.kernel.org, torvalds@linux-foundation.org

On Sat, Aug 15, 2009 at 7:57 AM, Pekka Enberg<penberg@cs.helsinki.fi> w=
rote:
> + =A0 =A0 =A0 } else if (token->ident =3D=3D &__SHRT_MAX__ident) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 replace_with_integer(token, __SHRT_MAX_=
_);
> + =A0 =A0 =A0 } else if (token->ident =3D=3D &__SCHAR_MAX__ident) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 replace_with_integer(token, __SCHAR_MAX=
__);
> + =A0 =A0 =A0 } else if (token->ident =3D=3D &__INT_MAX__ident) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 replace_with_integer(token, __INT_MAX__=
);
> + =A0 =A0 =A0 } else if (token->ident =3D=3D &__LONG_MAX__ident) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 replace_with_integer(token, __LONG_MAX_=
_);
> + =A0 =A0 =A0 } else if (token->ident =3D=3D &__LONG_LONG_MAX__ident)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 replace_with_long_long(token, __LONG_LO=
NG_MAX__);
> + =A0 =A0 =A0 } else if (token->ident =3D=3D &__WCHAR_MAX__ident) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 replace_with_integer(token, __WCHAR_MAX=
__);


I am pretty sure that is not the way to do it in sparse.  If you just w=
ant
add some sparse builtin defines, it is much better to add them in
create_builtin_streams(). It would be even better to group them in a ne=
w
function create_builtin_define():

Some thing like:

add_pre_buffer("#weak_define __INT_MAX__ %d\n", __INT_MAX__);

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
