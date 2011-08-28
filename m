From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Re: LLVM and PSEUDO_REG/PSEUDO_PHI
Date: Sun, 28 Aug 2011 11:23:00 -0700
Message-ID: <CA+55aFxm9vB8mFFy7y4pctyOeOE=8CjYUvL1mDdOnp2CihPd9w@mail.gmail.com>
References: <alpine.DEB.2.00.1108252046090.6272@localhost6.localdomain6>
 <CA+55aFxRkS4HLeW18-q+4Co7kRdiQBv4wnD=GX5ymAGigXR3MQ@mail.gmail.com>
 <alpine.DEB.2.00.1108252107210.6272@localhost6.localdomain6>
 <4E58731A.7010708@garzik.org> <alpine.DEB.2.00.1108271104440.2570@localhost6.localdomain6>
 <4E58AE9E.1090601@garzik.org> <4E59478C.9000504@garzik.org>
 <alpine.DEB.2.00.1108280815530.2734@localhost6.localdomain6>
 <4E5A129F.1090801@garzik.org> <CA+55aFw5VYSXduhXrtQx5CM4ubvOoHtrbyF74Y_wOQpBxE6Vmw@mail.gmail.com>
 <20110828175255.GA10203@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48293 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750766Ab1H1SXW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 14:23:22 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7SINKYD017583
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 11:23:21 -0700
Received: by wyg24 with SMTP id 24so3568975wyg.19
        for <linux-sparse@vger.kernel.org>; Sun, 28 Aug 2011 11:23:20 -0700 (PDT)
In-Reply-To: <20110828175255.GA10203@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Aug 28, 2011 at 10:52 AM, Josh Triplett <josh@joshtriplett.org> wrote:
>>
>> You should consider all types to be just "blocks of memory", and
>> sparse has already calculated all offsets etc for you. As far as LLVM
>> is concerned, the memory has no structure, it's just a blob.
>
> I suspect LLVM's optimization passes won't particularly care for that
> approach.

That's fine. We've already done the CSE and alias analysis on the
thing. And as mentioned, trying to turn overlapping (or partial)
accesses into some "named accesses" is just *wrong*. They weren't
named in the C code either. They are accesses through pointer
arithmetic. Trying to make them be somehow named would just be crazy.

                       Linus
