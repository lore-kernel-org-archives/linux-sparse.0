From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] make sparse headers self-compilable...
Date: Tue, 11 Aug 2009 23:25:48 +0200
Message-ID: <200908112325.48345.kdudka@redhat.com>
References: <200908072227.08652.kdudka@redhat.com> <200908111240.06529.kdudka@redhat.com> <70318cbf0908111408u238bd057vd3e4578baa0fe32c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:52777 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753556AbZHKV0d (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Aug 2009 17:26:33 -0400
In-Reply-To: <70318cbf0908111408u238bd057vd3e4578baa0fe32c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: sparse <linux-sparse@vger.kernel.org>

On Tuesday 11 of August 2009 23:08:24 Christopher Li wrote:
> On Tue, Aug 11, 2009 at 3:40 AM, Kamil Dudka<kdudka@redhat.com> wrote:
> > I agree processing of multiple-includes could be painful for the SPARSE
> > preprocessor. But you don't solve it by avoiding multiple-includes in the
> > SPARSE code itself. If you want to pass the SPARSE code through SPARSE,
> > it's small enough to not bother us with performance.
>
> I am worry about adding too much duplicated include slow down the
> gcc compile of sparse itself. I know I am paranoid :-)

Tested just now (ccache turned off)...

With the original (not amended) patch:
$ make clean && time make -j9
real    0m0.966s
user    0m4.654s
sys     0m1.471s

With the amended patch:
$ make clean && time make -j9
real    0m0.989s
user    0m4.580s
sys     0m1.504s

Without any of my patches applied:
$ make clean && time make -j9
real    0m0.980s
user    0m4.596s
sys     0m1.495s

Note that the results fluctuated approx 10% during runs.

My conclusion: absolutely no impact on gcc compile time.

Kamil
