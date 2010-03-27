From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Sat, 27 Mar 2010 10:16:38 +0100
Message-ID: <201003271016.39291.kdudka@redhat.com>
References: <1268097872.16227.10.camel@mj> <201003211627.14164.kdudka@redhat.com> <70318cbf1003240307m6be38384l3524923484e493ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49697 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345Ab0C0JSr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Mar 2010 05:18:47 -0400
In-Reply-To: <70318cbf1003240307m6be38384l3524923484e493ce@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pavel Roskin <proski@gnu.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Wednesday 24 of March 2010 11:07:04 Christopher Li wrote:
> That is just too much. Most of the warning is coming from enum or
> operation. e.g.
> .type =3D KW_SPECIFIER | KW_SHORT,
> lookup_keyword(token->ident, NS_KEYWORD | NS_TYPEDEF);

Looking once again, I don't think that's the case.  The warnings do not=
 come=20
from the "enum or" operation, but they come from passing the integral r=
esult=20
to enum variable (or arg).  Instead of weaking my patch, we may improve=
 the=20
code of sparse and add explicit casts back to enum:

    .type =3D (enum keyword) (KW_SPECIFIER | KW_SHORT),
    lookup_keyword(token->ident, (enum namespace) (NS_KEYWORD | NS_TYPE=
DEF));


The whole problem can be narrowed down to a simple test-case:

    int main()
    {
        enum {
            A =3D 0x1,
            B =3D 0x2
        } val =3D A | B;

        return val;
    }


Here is what sparse gives:
$ ./sparse enum.c
enum.c:1:10: warning: non-ANSI function declaration of function 'main'
enum.c:6:15: warning: conversion of
enum.c:6:15:     int to
enum.c:6:15:     int enum <noident>


Here is what g++ gives:
$ g++ enum.c
enum.c: In function =E2=80=98int main()=E2=80=99:
enum.c:6: error: invalid conversion from =E2=80=98int=E2=80=99 to =E2=80=
=98main()::<anonymous enum>=E2=80=99

Kamil
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
