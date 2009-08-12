From: Blue Swirl <blauwirbel@gmail.com>
Subject: Re: [PATCH 0/2] Fix sparc64 and x86_64 issues
Date: Wed, 12 Aug 2009 21:42:00 +0300
Message-ID: <f43fc5580908121142i207fd9di17c7070de1e74856@mail.gmail.com>
References: <f43fc5580908051151o560e73bdw50c3d575f50f7096@mail.gmail.com>
	<f43fc5580908061323s61bfaf23hcbc366a74ad4de09@mail.gmail.com>
	<70318cbf0908061416o1956a2f6vce8f17d59e8b5f78@mail.gmail.com>
	<70318cbf0908101049v5958c121s320a5528d8fae032@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:1966 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767AbZHLSmT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 12 Aug 2009 14:42:19 -0400
Received: by fg-out-1718.google.com with SMTP id e12so852505fga.17
        for <linux-sparse@vger.kernel.org>; Wed, 12 Aug 2009 11:42:20 -0700 (PDT)
In-Reply-To: <70318cbf0908101049v5958c121s320a5528d8fae032@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Mon, Aug 10, 2009 at 8:49 PM, Christopher Li<sparse@chrisli.org> wrote:
> On Thu, Aug 6, 2009 at 2:16 PM, Christopher Li<sparse@chrisli.org> wrote:
>> On Thu, Aug 6, 2009 at 1:23 PM, Blue Swirl<blauwirbel@gmail.com> wrote:
>>> On Wed, Aug 5, 2009 at 9:51 PM, Blue Swirl<blauwirbel@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> With these patches, I can run Sparse on OpenBIOS sources (which use
>>>> libgcc) also when compiling for 64 bit targets. 64 bit targets use 128
>>>> bit double cells, just like 64 bit double cells are used on 32 bit
>>>> targets.
>>>>
>>>> I'm not sure if 'long long long' is actually used, libgcc uses
>>>> __attribute__ ((mode (TI))).
>>
>> The change looks reasonable.
>>
>> I feel that we can use:
>>
>> #define MOD_ALL_LONG (MOD_LONG | MOD_LONGLONG | MOD_LONGLONGLONG)
>>
>
> I push the change does that. Please verify.

Seems to work, thanks!
