Return-Path: <SRS0=AbyH=DC=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7ECC4363D
	for <linux-sparse@archiver.kernel.org>; Fri, 25 Sep 2020 05:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2EC2137B
	for <linux-sparse@archiver.kernel.org>; Fri, 25 Sep 2020 05:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFEmBWod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgIYFiB (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 25 Sep 2020 01:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgIYFiB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 25 Sep 2020 01:38:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DEDC0613CE
        for <linux-sparse@vger.kernel.org>; Thu, 24 Sep 2020 22:38:00 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e23so1961608eja.3
        for <linux-sparse@vger.kernel.org>; Thu, 24 Sep 2020 22:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lykeUZOWKModURcdCLS55Lbaxl88noEnmZCIJUuUdLM=;
        b=rFEmBWodLkM1vf7qP7Ervs9ak1Q4lQdb0Zk7ws7TMTm7MG1yas74cBsTaUVn3BXXkM
         7E5U2C1WVvmjlFtnW6IXouDfvgu9/aTNWPzKkwncHe6pkBhVOMDMKt8a2fh0V8RtBBBM
         uBqX3EnTydxWThx3iIWybQQikr3lppLQZ+MYw/L7NdT7vpIM67CJuuwjcb9e5eirQgpW
         1wcSIFp9HVAU9Yvz35mIh/i3sDwPSthLU9rNxy+3KOR+ViY4o45EDpY+C+Y2EzQ9SxkJ
         5EOeC+JpkikTjq7nabhesai6IPSjJPDtLWkNtxNDiZsszTrP68/pFfontiGrPAh4FrQP
         SSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lykeUZOWKModURcdCLS55Lbaxl88noEnmZCIJUuUdLM=;
        b=n3mHsPCPk/m7r8uN6BH3jXWeMv3CF66wEbxo/VdlFkdgSspzSGeKK0trhPFqtoHPS4
         p5yGy6ikUX9Yxtq3PNc5Ggkeb9kZH7R9ioMfzpob91g8yZqSa719n1zLMBFl74HkLfDi
         v9V3Bfs1H3mlXP7ruaBC5ZNxd9PPrdBhu6pWVEmV3VMFS0qfazxV8ty2GlBnjlR0NGld
         Ih38IpTPpk+23e1Gtlw3V1Y6Uhx4IojWOZOcz98i/Kw9Fp8JVQJM0gaZ9hJV8DzjA9yd
         3kUp1PaTIKjmdp9NY4F6F/6TqPXJ79wIU3cFNjk/Nss4fdtanCZp1spvc12a+mJqDDFv
         CWMQ==
X-Gm-Message-State: AOAM533gy9SwJJ3BNmRWI9vL6k8FbBFyit7tkNwkgNh0BttX+641svm3
        x37BXOHpQMlyCqnoaE9JCzY=
X-Google-Smtp-Source: ABdhPJxRXcupyPjXFETX5EmZAv0Tn+sUtEA7jlUVARInqHif3OXO7/Vt6AcJ4vwEdfApa6Eg1ZoYOg==
X-Received: by 2002:a17:906:6ce:: with SMTP id v14mr1014271ejb.451.1601012279326;
        Thu, 24 Sep 2020 22:37:59 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id g11sm1004194edj.85.2020.09.24.22.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 22:37:58 -0700 (PDT)
Subject: Re: Segmentation fault when running sparse with current linux master
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Christian Eggers <ceggers@arri.de>
Cc:     linux-sparse@vger.kernel.org, Dirk Mueller <dmueller@suse.com>
References: <1832426.vqaiCtIcaR@n95hx1g2>
 <20200917142017.5fhdjdfrwjyjqlpu@ltop.local> <4184357.m9dUj1Odhv@n95hx1g2>
 <20200924193817.5ilitvaqneach5pg@ltop.local>
From:   Jiri Slaby <jirislaby@gmail.com>
Autocrypt: addr=jirislaby@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <141c85b6-f607-7594-ed3f-49684fe4bb3a@gmail.com>
Date:   Fri, 25 Sep 2020 07:37:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924193817.5ilitvaqneach5pg@ltop.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On 24. 09. 20, 21:38, Luc Van Oostenryck wrote:
> On Mon, Sep 21, 2020 at 09:44:00AM +0200, Christian Eggers wrote:
>> Hi Luc,
>>
>> On Thursday, 17 September 2020, 16:20:17 CEST, Luc Van Oostenryck wrote:
>>> On Thu, Sep 17, 2020 at 01:08:57PM +0200, Christian Eggers wrote:
>>>> Build of the current linux kernel breaks on my system due to segmentation
>>>> fault when running sparse.
>>>>
>>>> Sparse version: 0.6.2 (built by openSUSE build service)
>>>
>>> Hi,
>>>
>>> This has already been reported and fixed in the main tree in late July.
>>> It's not clear to me if the latest OpenSUSE packages for sparse contain
>>> or not the needed fix.
>>>
>>> Can you try the version compiled from the source? It's super-easy:
>>>       cd $dir
>>>       git clone git://git.kernel.org/pub/scm/devel/sparse/sparse.git
>>>       cd sparse
>>>       make
>>>       cp sparse ~/bin/
>>>
>>
>> I fetched the source RPM from openSUSE and replaced the 0.6.2 tar.xz with the
>> current master. After building an updating the RPM, sparse doesn't crash
>> anymore.
>>
>> openSUSE ships two versions of sparse [1]:
>> - official release: 20180324
>> - experimental: 0.6.2
>>
>> It seems that both version are affected from this problem. The "experimental"
>> version should be automatically updated after a new version of sparse is
>> released. The "official release" will probably only accept patches resolving
>> specific problems. If you can provide a patch against 20180324, I would try to
>> write a bug report against the openSUSE package. This could save some time for
>> the next person stumbling over this problem... If you provide the commit id,
>> openSUSE can also decide themself whether to fix or upgrade the current
>> version.
> 
> In the official tree, there is a branch 'maint-v0.6.2' which just contain
> 4 patches fixing some problems with the release v0.6.2, the second patch
> 	77f35b796cc8 ("generic: fix missing inlining of generic expression")
> being the one fixing this problem.

Being fixed in Tumbleweed:
https://build.opensuse.org/request/show/837254

If you want the fix on older distros, we can do that, but you have to
create a bug against the product first… 20180324 is pretty old version
and is both in 15.1 and even 15.2.

thanks,
-- 
js
