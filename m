From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] test-suite: handle format with filename.c not existing
Date: Wed, 24 Jan 2018 09:48:07 -0800
Message-ID: <bb561f3d-342c-4f6c-5309-e16aa6fdafa4@infradead.org>
References: <5d19aa93-b421-eb1f-3a4c-92fc9476747a@infradead.org>
 <20180124082814.a36sur5e7cusrleb@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:33091 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964826AbeAXRsM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 24 Jan 2018 12:48:12 -0500
In-Reply-To: <20180124082814.a36sur5e7cusrleb@ltop.local>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On 01/24/2018 12:28 AM, Luc Van Oostenryck wrote:
> On Mon, Jan 22, 2018 at 11:05:09AM -0800, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> In error(), quiet is undefined when the command:
>>   $ ./test-suite format filename1.c foobar1
>>
>> is used and filename1.c does not exist. This causes a shell script error:
>>   ./test-suite: line 147: [: : integer expression expected
>>
>> because $quiet is undefined in
>>   [ "$quiet" -ne 1 ] && echo "error: $1"
>> so the error message is lost.
>>
>> Just initialize quiet before any command line parsing.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> cfr: https://marc.info/?l=linux-sparse&m=151273892009415

I don't think that will fix the original problem that I posted the
patch for.


-- 
~Randy
