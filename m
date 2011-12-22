From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/3] sparse, llvm: Add test case for <stdbool.h> type
Date: Wed, 21 Dec 2011 16:23:04 -0800
Message-ID: <CANeU7QmBSjM+d3atTakQpUPKLY7hmRxfH044uAigMF8GevaAjg@mail.gmail.com>
References: <1324459528-9344-1-git-send-email-penberg@kernel.org>
	<1324459528-9344-2-git-send-email-penberg@kernel.org>
	<20111221095810.GA27308@leaf>
	<CAOJsxLEOy+=xYUTieDpx6=GLUUXpCW0tv4g_Xd0Ow_qz3D7a6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:65381 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436Ab1LVAXF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 21 Dec 2011 19:23:05 -0500
Received: by yenm11 with SMTP id m11so4977333yen.19
        for <linux-sparse@vger.kernel.org>; Wed, 21 Dec 2011 16:23:04 -0800 (PST)
In-Reply-To: <CAOJsxLEOy+=xYUTieDpx6=GLUUXpCW0tv4g_Xd0Ow_qz3D7a6Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Dec 21, 2011 at 2:18 AM, Pekka Enberg <penberg@kernel.org> wrote:
> On Wed, Dec 21, 2011 at 11:58 AM, Josh Triplett <josh@joshtriplett.org> wrote:
>> Do we want tests that depend on system header files?
>
> I changed it to use _Bool instead. Thanks!

This series looks great to me.

Thanks

Chris
