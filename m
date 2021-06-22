Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0877C48BDF
	for <linux-sparse@archiver.kernel.org>; Tue, 22 Jun 2021 06:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31B660720
	for <linux-sparse@archiver.kernel.org>; Tue, 22 Jun 2021 06:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhFVGr7 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 22 Jun 2021 02:47:59 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46667 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhFVGr6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Jun 2021 02:47:58 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id A674C1223;
        Tue, 22 Jun 2021 02:45:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 22 Jun 2021 02:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naive.systems;
         h=to:cc:from:subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=fm2; bh=OHWL/kFlHJnamrJtbhKt2sU1qE
        JmvCmv7bKGlUMLpt0=; b=rQ0fNoolOu/VAbAl0/x6sAWuQ2xW3h7F+/Lotv3kjV
        KSgG0hsulRvwzGqmVGXWIVBx0R8l0NHHd7yJ7XQhaQoDTEsO3Dxt23gHFDV26DP+
        p4wAO1XvTdLfJtF3vJvn6p0MgAvRPDGBzQy2QZ98EPg/JWPeHpW5AKo1GQDmjpYU
        n9a4ALXi9jdLjTKYBggipLOUzWoD06h4+LqJxZobmHhk8qxcasPZCHKJnxUcNCby
        0ZR3oVmPkpdjy94sN6Cz9Na8C8Y5JdaiKOBFQHKIOZs2lwCNXntf104BGShGOEun
        H4+uNeybVvx79bDS9l3Axc1EjZtNhgVoXMNG4uP21ENg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=OHWL/k
        FlHJnamrJtbhKt2sU1qEJmvCmv7bKGlUMLpt0=; b=ajynjiWT4x1vuIIRbKy8X/
        TJOq6/y9WnSQl3b+e11qU6z4r/gbKsgDSEmFVM+QBkOi0whGeYdVxz4Rr+QlMOdH
        QRElublbbUhmikdAyymKvjgv5lI8n01LSPsDWHJt9/zDGkANgwDXHg8QICH8Vun4
        mzUVqoSpDhjjQAXT5xzjd2nfQixj3pA/B/cJiLiG0JAxXn5Gba5XaOIuxvzFw3VC
        cbDxZkW1N82xquigfqvSx7ZnjrgTfhchmNJPgqNQyhtHHa9H5oGO1+0XWBHpY8I+
        1v1EIC1oxfevuL/F+T5Ko4UJmjSQ0MObBOKgPhJMO92CreFJo7YpWbnB9IvLwZsg
        ==
X-ME-Sender: <xms:FofRYB1Z0Y3uBz3xbmfqsGCiUaD46Js_cUyaRUc17eyLc0FrCtZyug>
    <xme:FofRYIEb5QyEMIahcSPS5zhI-hnoFVOrMrAklhKAL-RyrVS3kSNExAGl15V3IUxqD
    FLNbYGJGvIugMeRud8>
X-ME-Received: <xmr:FofRYB70joTWObAt60kGAOxjuwjxalBzZJxd3sSPiDa8ATE1skxG4X7k31rjh-lopRRrbZb1d4eXmypGJjYMy7kS8MPuMNW_QbfTtSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeegtddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefvhffukffffgggtgfgsehtjeertddtfeejnecuhfhrohhmpefmvgcuffhu
    uceoughukhgvsehnrghivhgvrdhshihsthgvmhhsqeenucggtffrrghtthgvrhhnpeevke
    dvfeffieehgfffteffudffuefhhfdttedutedtfedujeelvdejudeulefggeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeguuhhkvgesnhgrih
    hvvgdrshihshhtvghmsh
X-ME-Proxy: <xmx:FofRYO1QvDRZZo7CIC0_PGR7nmqQWhuf-BwiKg_akj_y54LWGmwOPQ>
    <xmx:FofRYEEnowFCvF2IyUsQlzXPt4AxpKB188ciQQzbCg1gwciNeAPpxQ>
    <xmx:FofRYP-4jlaFNbyq7q4nWrK4vFkiJAkxoGckZ5i2Tn0fVMKWQqLRqg>
    <xmx:FofRYPM2r_Js2WjLMB5e0u3-JcYRm2THARbKJQ3vicbUCfBuKmNodQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jun 2021 02:45:42 -0400 (EDT)
To:     linux-sparse@vger.kernel.org
Cc:     Xiao Jia <xjia@naive.systems>
From:   Ke Du <duke@naive.systems>
Subject: check idea: include sparse as a library in C++
Message-ID: <88596afa-76f2-8c2f-d80e-572d1e57369e@naive.systems>
Date:   Tue, 22 Jun 2021 02:45:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,

I want to include sparse as a library in C++ and access fields of the 
structs such as symbol and expression directly, but some of the 
variables in sparse are keywords in C++ so they cannot be included in 
C++ directly. I have several fixes below that are not ideal, and any 
feedback is appreciated.

1. Append an underscore to C++ keywords, for instance change new to 
new_. The change only involves the code that I included so there might 
be some C++ keywords in sparse that are unchanged.

2. Replace every keyword with a macro:

     #ifdef __cplusplus
     #define NEW new_
     #else
     #define NEW new
     #endif

Similar to solution 1, this is not complete, and both 1 and 2 involves 
about 200 changes already.

3. When including sparse header files, guard them with

     #define new new_
     #include ...
     #define new_ new

This does not involve change to sparse but it imposes weird restriction 
to the ordering of other C++ libraries that I do not understand at all.

I can send the patches if one of the fixes is acceptable. Alternatively, 
if there is a better way, please let me know.

Cheers,
-- Ke
