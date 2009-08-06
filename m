From: Hannes Eder <hannes@hanneseder.net>
Subject: Re: [PATCH] linearize.h: sanitize header
Date: Thu, 6 Aug 2009 19:49:23 +0200
Message-ID: <154e089b0908061049o714bd341v733e828166a8f604@mail.gmail.com>
References: <200908061102.14935.kdudka@redhat.com>
	 <154e089b0908060409v4dff4785x456b5aad2460ed84@mail.gmail.com>
	 <70318cbf0908061010w737ac3d7j1feb1f9744217df7@mail.gmail.com>
	 <200908061927.47201.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f228.google.com ([209.85.220.228]:62459 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbZHFRtZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 6 Aug 2009 13:49:25 -0400
Received: by fxm28 with SMTP id 28so894329fxm.17
        for <linux-sparse@vger.kernel.org>; Thu, 06 Aug 2009 10:49:24 -0700 (PDT)
In-Reply-To: <200908061927.47201.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Christopher Li <sparse@chrisli.org>, sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 6, 2009 at 19:27, Kamil Dudka<kdudka@redhat.com> wrote:
> On Thursday 06 of August 2009 19:10:30 Christopher Li wrote:
>> I would just apply the change to the header file and related variables.
>> The linearize.h is consider an API header file for other sparse application
>> to use. So we'd better not assume too much on the sparse caller side.
>>
>> I agree with Kamil that rename variable in linearize.c offer no real
>> benefits. I consider it more of a personal preference thing. And it is
>> internal to linearize.c. At this point renaming variable will mess up with
>> annotations. It is not good enough reason to do it just to make
>> the editor happy.
>
> Well, let's make a tradeoff - we can only change the identifiers
> in linearize.h and the corresponding identifiers in linearize.c. I admit it
> could be confusing when we have different identifiers in the prototype and
> different identifiers in the function body. New version of the patch is
> attached.

LGTM

Acked-by: Hannes Eder <hannes@hanneseder.net>

Best,
-Hannes
