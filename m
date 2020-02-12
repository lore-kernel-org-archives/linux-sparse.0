From: Shannon Nelson <snelson@pensando.io>
Subject: Re: smatch/sparse complaints on static assertion
Date: Tue, 11 Feb 2020 17:01:45 -0800
Message-ID: <23e34336-22fa-d14d-c765-877abc05df12@pensando.io>
References: <e588417e-1bf4-35e3-d8d9-9911fe29e0f5@pensando.io>
 <ecdd10cb-0022-8f8a-ec36-9d51b3ae85ee@pensando.io>
 <20200212003128.pieng2rlw7mykhvk@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf1-f169.google.com ([209.85.210.169]:46991 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgBLBBr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Feb 2020 20:01:47 -0500
Received: by mail-pf1-f169.google.com with SMTP id k29so312662pfp.13
        for <linux-sparse@vger.kernel.org>; Tue, 11 Feb 2020 17:01:47 -0800 (PST)
In-Reply-To: <20200212003128.pieng2rlw7mykhvk@ltop.local>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

On 2/11/20 4:31 PM, Luc Van Oostenryck wrote:
> On Tue, Feb 11, 2020 at 09:41:05AM -0800, Shannon Nelson wrote:
>> Hi All,
>>
>> I'm getting complaints from smatch on the ionic network driver's static
>> assertions and am not sure why it was complaining.  Dan Carpenter suggested
>> this might be an issue in sparse with how it is calculating the sizes of the
>> unions.
>>
>> I ran this at the top of a pretty recent net-next tree
>> (v5.5-rc7-1839-g8192c36)
>> $ ../smatch/smatch_scripts/kchecker drivers/net/ethernet/pensando/ionic/
>>
>> And got several copies of this:
>>
>> drivers/net/ethernet/pensando/ionic/ionic_dev.h:38:1: error: static
>> assertion failed: "sizeof(union ionic_dev_regs) == 4096"
> ...
>   
>> These static assertion lines have been fine up until now and I'm pretty sure
>> they are correct.
>>
>> Has this issue been seen elsewhere?  Or is there something I can do in our
>> code to get rid of the complaints?
> This is caused by the packing of the structs. It's using
> 	#pragma pack(push, 1) / #pragma pack(pop)
> which is not supported by Sparse. Packing via __attribute__((packed))
> is incomplete but the pragmas are currently completly ignored.
>
> -- Luc Van Oostenryck

Ah, that makes sense.  Thanks.
sln
