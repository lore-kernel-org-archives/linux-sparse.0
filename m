From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] doc: correct some spelling
Date: Mon, 15 Jun 2020 00:42:55 +0100
Message-ID: <c02ba9b6-2367-6963-b682-d19812cd9692@ramsayjones.plus.com>
References: <a03299d8-fd2f-8f04-2bd0-e94091247bdb@ramsayjones.plus.com>
 <20200614220530.x4nr7zhlmxuk7zj7@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout02.plus.net ([212.159.14.17]:43943 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgFNXm6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 14 Jun 2020 19:42:58 -0400
In-Reply-To: <20200614220530.x4nr7zhlmxuk7zj7@ltop.local>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>



On 14/06/2020 23:05, Luc Van Oostenryck wrote:
> On Sun, Jun 14, 2020 at 08:36:38PM +0100, Ramsay Jones wrote:
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>>
>> The only spelling fixes in the manpage are s/exemple/example/,
>> s/trigered/triggered/ and s/&/and/. I would not normally change
>> any 'formatting' in sparse.1, but the '{ 0 }' and '{ }' got
>> split across line-endings, so I removed the spaces.
>> (other solutions are possible ...)
> 
> Thank you again for noticing and fixing these typos.
> 
> Yes, the formatting is often very bad on the man page
> because of bad or missing linebreaks.
> I changed this part of your patch to use a non-breakable
> space for the '{ 0 }' and '{ }'. They look, I think, better.

Yeah, I tried a nbsp too (that was part of my 'other solutions'), and
compared the two outputs; there wasn't much difference in the output
so I went with the 'easier' patch. ;-)

This looks good. (I see you noticed a couple more ...)

ATB,
Ramsay Jones
