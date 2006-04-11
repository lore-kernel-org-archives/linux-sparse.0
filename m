From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sparse: gcc 4.1 warnings
Date: Mon, 10 Apr 2006 20:30:28 -0400
Message-ID: <443AF8A4.2090007@garzik.org>
References: <20060408041419.GA8943@havoc.gtf.org> <20060410132157.4AF15C000E2@dunnock.rentec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:11209 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932207AbWDKAad (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 10 Apr 2006 20:30:33 -0400
In-Reply-To: <20060410132157.4AF15C000E2@dunnock.rentec.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Morten Welinder <terra@gnome.org>
Cc: linux-sparse@vger.kernel.org

Morten Welinder wrote:
> This doesn't look quite right.
>=20
> So it looks like gcc 4.1 complains over non-used values that are the
> result of a cast.  That feels obnoxious, but in this case maybe you

Yes, it is :)  See below for vanilla sparse build under gcc 4.1...


> could try just casting to void in add_ptr_list -- is the value ever
> used?

All uses except for add_pseudo() ignore the return value.

	Jeff



gcc -O -g -Wall -Wwrite-strings -fpic -DDEBUG   -c -o lib.o lib.c
In file included from lib.c:21:
lib.h: In function =91add_symbol=92:
lib.h:171: warning: value computed is not used
lib.h: In function =91add_statement=92:
lib.h:176: warning: value computed is not used
lib.h: In function =91add_expression=92:
lib.h:181: warning: value computed is not used
In file included from lib.c:28:
linearize.h: In function =91add_bb=92:
linearize.h:227: warning: value computed is not used
linearize.h: In function =91add_instruction=92:
linearize.h:232: warning: value computed is not used
linearize.h: In function =91add_multijmp=92:
linearize.h:237: warning: value computed is not used
linearize.h: In function =91add_pseudo_ptr=92:
linearize.h:266: warning: value computed is not used
gcc -O -g -Wall -Wwrite-strings -fpic -DDEBUG   -c -o scope.o scope.c
In file included from scope.c:15:
lib.h: In function =91add_symbol=92:
lib.h:171: warning: value computed is not used
lib.h: In function =91add_statement=92:
lib.h:176: warning: value computed is not used
lib.h: In function =91add_expression=92:
lib.h:181: warning: value computed is not used
gcc -O -g -Wall -Wwrite-strings -fpic -DDEBUG   -c -o expression.o=20
expression.c
In file included from expression.c:21:
lib.h: In function =91add_symbol=92:
lib.h:171: warning: value computed is not used
lib.h: In function =91add_statement=92:
lib.h:176: warning: value computed is not used
lib.h: In function =91add_expression=92:
lib.h:181: warning: value computed is not used
[...]
