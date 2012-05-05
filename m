From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: dependency tee from c parser entities downto token
Date: Fri, 4 May 2012 17:32:31 -0700
Message-ID: <20120505003231.GA3990@leaf>
References: <CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com>
 <CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com>
 <CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com>
 <4FA38635.5060300@gaisler.com>
 <CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com>
 <4FA3B14A.3070609@gaisler.com>
 <4FA3CD58.80809@gmail.com>
 <20120504153054.GA5994@leaf>
 <4FA441E0.6010701@gmail.com>
 <CANeU7QkoHY_L9oQ4WuxPFUABwFznTfAMWMSRz7-Pe98dSiuiGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:38397 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758571Ab2EEAcl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 May 2012 20:32:41 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7QkoHY_L9oQ4WuxPFUABwFznTfAMWMSRz7-Pe98dSiuiGQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Konrad Eisele <eiselekd@gmail.com>, Konrad Eisele <konrad@gaisler.com>, linux-sparse@vger.kernel.org

On Fri, May 04, 2012 at 03:30:21PM -0700, Christopher Li wrote:
> On Fri, May 4, 2012 at 1:53 PM, Konrad Eisele <eiselekd@gmail.com> wr=
ote:
> > make C=3D2:
> >
> > original sparse:
> > real =A0 =A017m54.997s
> > user =A0 =A015m25.181s
> > sys =A0 =A0 2m11.281s
> >
> > decpp-sparse from "git clone git://git.code.sf.net/p/decpp/code dec=
pp "
> > real =A0 =A018m29.748s
> > user =A0 =A016m18.155s
> > sys =A0 =A0 2m13.221s
> >
> > But decpp is not written with performance in common cases in mind.
> > The 2 runs probably also depend on other factors too.
> > I cant think that 4 bytes extra for each token can have a big impac=
t,
> > if I would implement it that way (it is not in decpp).
>=20
> The deal breaker is not able to free token list if other program usin=
g
> sparse don't need it.

=46rom the top of token.h:

/*
 * Basic tokenization structures. NOTE! Those tokens had better
 * be pretty small, since we're going to keep them all in memory
 * indefinitely.

Has that changed?  If so, perhaps the comment needs fixing.  If not, I
suspect the problem lies elsewhere; perhaps in the extra levels of
indirection introduced by the patch, rather than in the extra memory
usage.

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
