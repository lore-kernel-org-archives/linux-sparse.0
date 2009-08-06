From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] Fix sparc64 and x86_64 issues
Date: Thu, 6 Aug 2009 14:16:59 -0700
Message-ID: <70318cbf0908061416o1956a2f6vce8f17d59e8b5f78@mail.gmail.com>
References: <f43fc5580908051151o560e73bdw50c3d575f50f7096@mail.gmail.com>
	 <f43fc5580908061323s61bfaf23hcbc366a74ad4de09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f183.google.com ([209.85.212.183]:41535 "EHLO
	mail-vw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbZHFVRA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 6 Aug 2009 17:17:00 -0400
Received: by vws13 with SMTP id 13so1104618vws.22
        for <linux-sparse@vger.kernel.org>; Thu, 06 Aug 2009 14:17:00 -0700 (PDT)
In-Reply-To: <f43fc5580908061323s61bfaf23hcbc366a74ad4de09@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Blue Swirl <blauwirbel@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Aug 6, 2009 at 1:23 PM, Blue Swirl<blauwirbel@gmail.com> wrote:
> On Wed, Aug 5, 2009 at 9:51 PM, Blue Swirl<blauwirbel@gmail.com> wrote:
>> Hi,
>>
>> With these patches, I can run Sparse on OpenBIOS sources (which use
>> libgcc) also when compiling for 64 bit targets. 64 bit targets use 128
>> bit double cells, just like 64 bit double cells are used on 32 bit
>> targets.
>>
>> I'm not sure if 'long long long' is actually used, libgcc uses
>> __attribute__ ((mode (TI))).

The change looks reasonable.

I feel that we can use:

#define MOD_ALL_LONG (MOD_LONG | MOD_LONGLONG | MOD_LONGLONGLONG)

Eventually the expression needs to handle 128 bit long constant as well.

Chris
