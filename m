From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC/PATCH 1/2] sparse: Fix including glibc headers on x86-64
Date: Fri, 23 Mar 2012 11:47:25 -0700
Message-ID: <CANeU7QmR0mdPFSsScZdtdekZR7t9PUbAx8piXygyGVy=uXMJ1A@mail.gmail.com>
References: <1319373420-8967-1-git-send-email-penberg@cs.helsinki.fi>
	<CANeU7Q=h1egUD1cSpNwmAnemXPTa0k0OrKQOY6Rhow_5hb1hYA@mail.gmail.com>
	<1332493309.2882.6.camel@pasglop>
	<CANeU7Qnd23X+jpM6Byx12igAugv=-EyQ1hN8DtG4N32y1yp7pQ@mail.gmail.com>
	<CANeU7QkzM-ZLZ_NgstAjpZdSe-eSgj+-SxEqUX-g5kXBTHrCvg@mail.gmail.com>
	<20120323180320.GA17003@leaf>
	<CANeU7Qmq+VMxPeRfY9wt9Jxb1NLHdWGAFONDpnk2th8Asqc4kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:62899 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629Ab2CWSr0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Mar 2012 14:47:26 -0400
Received: by wejx9 with SMTP id x9so2875729wej.19
        for <linux-sparse@vger.kernel.org>; Fri, 23 Mar 2012 11:47:25 -0700 (PDT)
In-Reply-To: <CANeU7Qmq+VMxPeRfY9wt9Jxb1NLHdWGAFONDpnk2th8Asqc4kQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, penberg@cs.helsinki.fi, linux-sparse@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Frederic Crozat <fcrozat@suse.com>

On Fri, Mar 23, 2012 at 11:29 AM, Christopher Li <sparse@chrisli.org> wrote:
>
> Thanks for the review.

Applied and pushed, along with merging the sparse-llvm again.

Chris
