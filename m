From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH 1/2] sparse, llvm: group PHI nodes at the top of each BB
Date: Wed, 17 Oct 2012 19:44:20 +0200
Message-ID: <20121017174420.GA2922@debian.debian>
References: <5074BD6B.2090501@pobox.com>
 <CAOJsxLF2AqK2N_R876jOOVmkHXyhe_OjyP_xfULUF5PAfKogMw@mail.gmail.com>
 <20121010163306.GA2846@debian.debian>
 <CAOJsxLE=UsuonXVPuDxL9jPGQj_M5xdvCUrk5u+m3U-s4Ao-hA@mail.gmail.com>
 <CAOJsxLEEBYMF4qcyBSpS7kaumzpQFm0McNexRtft3UJVwp==Xg@mail.gmail.com>
 <20121016201426.GD2932@debian.debian>
 <507DC95C.7010106@gmail.com>
 <CAOJsxLFXaWXcR8vF_DFPAaJZPJ_BTe47Q9GSkM-2MChaRBqkdw@mail.gmail.com>
 <507E55FC.5010202@gmail.com>
 <CAOJsxLGWCoskGTsKefWoCYPGuR_b5_QsMTnYkzTNX14t0HkKhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:43371 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755984Ab2JQRpZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Oct 2012 13:45:25 -0400
Content-Disposition: inline
In-Reply-To: <CAOJsxLGWCoskGTsKefWoCYPGuR_b5_QsMTnYkzTNX14t0HkKhg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Xi Wang <xi.wang@gmail.com>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Jeff Garzik <jgarzik@pobox.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Oct 17, 2012 at 07:41:52PM +0300, Pekka Enberg wrote:
> On 10/17/12 2:48 AM, Pekka Enberg wrote:
> >> Is LLVM able to optimize away the allocas and use registers instead in
> >> the emitted code?
> 
> On Wed, Oct 17, 2012 at 9:53 AM, Xi Wang <xi.wang@gmail.com> wrote:
> > Yes.  See the last part of my previous email, no load/store/alloca after
> > LLVM's -mem2reg pass.
> 
> Right. Jonathan, does Xi's suggestion sound reasonable to you? I'd
> certainly prefer that over instruction reordering.

It certainly does. Thanks, Xi!


Jonathan
