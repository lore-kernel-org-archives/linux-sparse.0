Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5681BC433E6
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 17:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 281F5229C4
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 17:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgL1RTi (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 12:19:38 -0500
Received: from avasout06.plus.net ([212.159.14.18]:33757 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgL1RTi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 12:19:38 -0500
Received: from [10.0.2.15] ([80.189.83.3])
        by smtp with ESMTPA
        id twAUkPhVRhO4HtwAVkCvaH; Mon, 28 Dec 2020 17:18:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1609175931; bh=Cwq5ns6HfwM8YpFaLArNYy3HF62ZFVsNx8SHqhMBk8c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rIu8hyTD0+zO0MZN58uPhu+xk7I0d2L/AbvHpMBOZ4j7kn7bYL6lifakZbyty7hXI
         rRJZEO4+JuIm7SK5RTGY5cqZZJVh3+lHl45/iDg8OTcPbd0RGphXFL0dbLih6C/a5T
         JpRKMeTDME0PtT69GcrcLnHCwR1pujE+kxntMBUBSini2/Stj9UbBeHhAbQ7c+Yzya
         qP9D9oAocXJ8YyL4+KH5vPg3DGdoD1ZTscLurpDvsL5A4uc88jmuq3s8Rx9mGcHCkk
         eflQ9TSDKj4DpovwgrJquR0+lLYH0w2DfAWjzQ9L11oHD/+KqEKDJLueUsXc+aoX4D
         zaqDDohrVea2g==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=SPPZqNnH c=1 sm=1 tr=0
 a=HN+d/rRCB1WM0IHjUF19mA==:117 a=HN+d/rRCB1WM0IHjUF19mA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=RUjHBxmlvnOCVcm5UY8A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 00/16] support __packed struct
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <6a00eea2-7371-de84-05fc-1375603ed7eb@ramsayjones.plus.com>
Date:   Mon, 28 Dec 2020 17:18:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDt2k/tFgdBKrBjbXzzG3U6+PaKY5ORmByqd9KMfhBHGcliiD1RSMOjc93R1FBpyznHOrRpYQMUTzm6yVAmEk7/Gl+7Kmltx7lq0Wx3XW9oXKM35M+5Q
 Zckh8O08Y045OBD333TTlhILdh/ATuP77+Sh0UV0WNO2qj7rMQcm6ojbIZU5R4POldNHWTM97ROz+w==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 26/12/2020 17:51, Luc Van Oostenryck wrote:
> During parsing, Sparse recognizes the attribute 'packed' but this
> attribute is otherwise ignored for several reasons:
> 1) the attribute in 'struct __attr { ... }' is wrongly handled as
>    belonging to the whole declaration but it should belong to the type,
> 2) the attribute in 'struct <name> { ... } __attr;' is simply ignored,
> 3) the layout of packed bitfields need special care.
> 
> This series contains 2 parts:
> 1) handling of type attributes
> 2) correct layout of packed structs, including packed bitfields.
> 
> 
> This series is also available for review and testing at:
>   git://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git packed-v2

I left a couple of minor comments, but (apart from patch #16) this
otherwise LGTM.

Patch #16 also looks good, but I would need to study it a bit more
than I have time available to be totally happy. It does not seem
to be handling the 'lowering' of 'odd bit-sized' symbols created in
the previous patch (to answer my own question), so I would have to
apply the patches (or fetch the above branch) to study some more.

Hope you had a good holiday.

ATB,
Ramsay Jones
