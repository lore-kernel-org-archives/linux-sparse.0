From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 2/5] sparse: Enable unhandled validation tests
Date: Thu, 25 Aug 2011 13:30:20 +0300
Message-ID: <4E56243C.1070906@kernel.org>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org> <1314021451-24808-2-git-send-email-penberg@kernel.org> <CANeU7Q=xwx6TNA9PE_30=9i+KrCF0gRfXm2UPAXBpCg-7uncPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35311 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab1HYKaZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Aug 2011 06:30:25 -0400
Received: by ewy4 with SMTP id 4so851986ewy.19
        for <linux-sparse@vger.kernel.org>; Thu, 25 Aug 2011 03:30:24 -0700 (PDT)
In-Reply-To: <CANeU7Q=xwx6TNA9PE_30=9i+KrCF0gRfXm2UPAXBpCg-7uncPg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On 8/25/11 12:05 AM, Christopher Li wrote:
> On Mon, Aug 22, 2011 at 6:57 AM, Pekka Enberg<penberg@kernel.org>  wrote:
>> This patch enables unhandled tests that did not have "check-name" specified.
>> It's pointless not to run them.
> Good catch. Applied.
>
Is there something wrong with the following patches?

[PATCH 3/5] sparse: Fix __builtin_safe_p for pure and const functions
[PATCH 4/5] sparse, i386: Fix boolean bit size

Or haven't you gotten to them yet?
