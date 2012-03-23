From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC/PATCH 1/2] sparse: Fix including glibc headers on x86-64
Date: Fri, 23 Mar 2012 02:13:43 -0700
Message-ID: <CANeU7Qnd23X+jpM6Byx12igAugv=-EyQ1hN8DtG4N32y1yp7pQ@mail.gmail.com>
References: <1319373420-8967-1-git-send-email-penberg@cs.helsinki.fi>
	<CANeU7Q=h1egUD1cSpNwmAnemXPTa0k0OrKQOY6Rhow_5hb1hYA@mail.gmail.com>
	<1332493309.2882.6.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59867 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab2CWJNo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Mar 2012 05:13:44 -0400
Received: by yhmm54 with SMTP id m54so2526017yhm.19
        for <linux-sparse@vger.kernel.org>; Fri, 23 Mar 2012 02:13:44 -0700 (PDT)
In-Reply-To: <1332493309.2882.6.camel@pasglop>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: penberg@cs.helsinki.fi, linux-sparse@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Frederic Crozat <fcrozat@suse.com>

On Fri, Mar 23, 2012 at 2:01 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> That reminds me we should also have a way to pass the arch triplet and
> have a good way to find a "default". On debian sid you need it to get
> all your standard includes for userspace, and we should really pass it
> to llvm in sparse-llvm.

I agree. The right direction to go is to have some arch parsing.
If we have those arch parsing, we don't need the cgcc script any more.

Converting all arch is pretty involved. I don't have a good way to test
non x86 platform.

We can start from -m32 parsing and work our way through the arch parsing.

Chris
