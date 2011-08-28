From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] Re: LLVM and PSEUDO_REG/PSEUDO_PHI
Date: Sun, 28 Aug 2011 10:52:55 -0700
Message-ID: <20110828175255.GA10203@leaf>
References: <alpine.DEB.2.00.1108252046090.6272@localhost6.localdomain6>
 <CA+55aFxRkS4HLeW18-q+4Co7kRdiQBv4wnD=GX5ymAGigXR3MQ@mail.gmail.com>
 <alpine.DEB.2.00.1108252107210.6272@localhost6.localdomain6>
 <4E58731A.7010708@garzik.org>
 <alpine.DEB.2.00.1108271104440.2570@localhost6.localdomain6>
 <4E58AE9E.1090601@garzik.org>
 <4E59478C.9000504@garzik.org>
 <alpine.DEB.2.00.1108280815530.2734@localhost6.localdomain6>
 <4E5A129F.1090801@garzik.org>
 <CA+55aFw5VYSXduhXrtQx5CM4ubvOoHtrbyF74Y_wOQpBxE6Vmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36292 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab1H1RxF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 13:53:05 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFw5VYSXduhXrtQx5CM4ubvOoHtrbyF74Y_wOQpBxE6Vmw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Aug 28, 2011 at 10:04:54AM -0700, Linus Torvalds wrote:
> On Sun, Aug 28, 2011 at 3:04 AM, Jeff Garzik <jeff@garzik.org> wrote:
> >
> > * need to start integrating struct support. =A0LLVM has a type syst=
em where
> > one defines data structures in the IR, then uses 'getelementptr' LL=
VM
> > instruction to build addresses for complex load/store operations. T=
he Linux
> > kernel uses a lot of function calls (indirect branches) from values=
 buried
> > deep within a struct.
>=20
> You really shouldn't need to do that.
>=20
> You should consider all types to be just "blocks of memory", and
> sparse has already calculated all offsets etc for you. As far as LLVM
> is concerned, the memory has no structure, it's just a blob.

I suspect LLVM's optimization passes won't particularly care for that
approach.

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
