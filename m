From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] sparse: Reduce 'test-suite' run output
Date: Sat, 27 Aug 2011 13:39:59 +0200
Message-ID: <20110827113959.GA15022@debian.debian>
References: <1314366621-29361-1-git-send-email-penberg@kernel.org>
 <CANeU7Q=xTrKKCkuB4_RcA7L=99=psZAWQiawqSLMMyOUK6E-jQ@mail.gmail.com>
 <alpine.DEB.2.00.1108271112110.2570@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:40001 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751114Ab1H0LkD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 07:40:03 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1108271112110.2570@localhost6.localdomain6>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Aug 27, 2011 at 11:13:17AM +0300, Pekka Enberg wrote:
> On Fri, 26 Aug 2011, Christopher Li wrote:
>=20
> >On Fri, Aug 26, 2011 at 6:50 AM, Pekka Enberg <penberg@kernel.org> w=
rote:
> >>There's more than 100 tests in the validation test suite. That make=
s it
> >>cumbersome to notice test breakage in because the results don't fit=
 on single
> >>page.
> >
> >Looks good in a terminal. But if the output is piped to a file, it w=
ill be hard
> >to read that file. We shouldn't do it for a non-terminal output.
>=20
> Right. How can I check if we're outputting to non-terminal?

You probably need a C helper, like this:

#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>

int main(int argc, char **argv)
{
	int fd, tmp;

	if (argc < 2) {
		printf("usage: %s fd\n", argv[0]);
		return EXIT_FAILURE;
	}

	errno =3D 0;
	fd =3D (int) strtol(argv[1], NULL, 10);
	if (errno =3D=3D ERANGE) {
		perror("bad fd");
		return EXIT_FAILURE;
	}

	tmp =3D isatty(fd);
	if (!tmp && errno =3D=3D EBADF)
		perror("");

	return tmp ? EXIT_SUCCESS : EXIT_FAILURE;
}

HTH,
	Jonathan Neusch=C3=A4fer
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
