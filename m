From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: sparse error on __int128
Date: Mon, 25 Jan 2016 13:42:58 -0500
Message-ID: <56A66CB2.5040707@redhat.com>
References: <55C9DD4F.9050805@redhat.com>
 <20160105000800.GA12116@macpro.local> <569659E9.1010703@redhat.com>
 <20160125174703.GA43281@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42154 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932102AbcAYSm7 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 13:42:59 -0500
In-Reply-To: <20160125174703.GA43281@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On 01/25/2016 12:47 PM, Luc Van Oostenryck wrote:
> On Wed, Jan 13, 2016 at 09:06:33AM -0500, Tony Camuso wrote:
> ...
>
>>> Now, of course, one could argue that sparse should also define __int128
>>> on platforms where gcc define it, on x86_64 thus.
>
> ...
>
>> So, I will apply the argument you so graciously supplied and posit that sparse
>> should define __int128 on platforms where gcc defines it, e.g. x86_64. :)
>>
>> It doesn't seem like a very intrusive change.
>
>
> Hehe :)
> Feel like writing a patch for it?
>
> Luc
>

Sure! ;)

