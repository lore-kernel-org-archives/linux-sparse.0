Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FECC4338F
	for <linux-sparse@archiver.kernel.org>; Fri, 13 Aug 2021 01:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B7B6109D
	for <linux-sparse@archiver.kernel.org>; Fri, 13 Aug 2021 01:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbhHMBZp (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 12 Aug 2021 21:25:45 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36753 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238173AbhHMBZo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 12 Aug 2021 21:25:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0AF685C00F9;
        Thu, 12 Aug 2021 21:25:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 12 Aug 2021 21:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naive.systems;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Hn7aVL7bQM6Yw
        k/Oi1gOF27Zgvko1Fiu2adWcnKtgUM=; b=TjkcQItr379MhzV71R2FTTjhIjerS
        XTCbe7j1cX2tNvJBevQeqjkAahHFuoggDeBRmtbcUU6bvBv2UiZwupxDkRoXfjkR
        EGYM9AIzxV0v63MWQiwDR6TdDdEOJ/9Nvu+20lpNnmkcGDkOgu4+saEEt1ZP8QbV
        3DokqBO/KoY1VPVY5oSBrbE6hlmgPfae7CEnLuliwpJMyFrZj28aqOcDC4ZhQZm7
        TuPdEC9g92upNn157OVP2ydncgcfnOil/phiUx7PnlwuHg4jLojEU7qwO8Inrjh8
        LPFfvi42t3SM49cxPdcmCG/V2sDeYJ0nko3lz9y1RkWZwqb0f+ijibcgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Hn7aVL7bQM6Ywk/Oi1gOF27Zgvko1Fiu2adWcnKtgUM=; b=a8UfVO4m
        WAyF870VVdvvVXM4Vt1RhlVoWlTSJ4m/3hCKnS+Omdm5xGhNytdTxT39Ty4tglnW
        Ut71xxCVJmOP5OukS8TqrexPC52001Le+9Re+Cu4CSk1XAvCjQi9sKt2YcEJKDoh
        HVSbBsualREiOatCk/1XLt4QwAMbHFAqN5sjaGakkJHTFinE2IucdHagaXmVfup+
        mxA1x6cePQ+ECRdfzdBO/WSXch4ICDiPobbkW2b68y6Wyf3MVfDYSVQqnjYCFPU6
        p/J2bHb0WXUZVNTXvBLG8x80L6bEToRGcoXGdijmuZhWz7Qiv4LQ4Hf64tksHKMe
        O4kbNaXWUBSIHA==
X-ME-Sender: <xms:_ckVYSFYoB_72vk19w3w25vaE-JGuDNgUDHtwGUxUmnyCnHCbH6QSw>
    <xme:_ckVYTVI1apvQHLoSoR5gKxSXCGNqvfjTCkEO9Ko5MSPgwvXdeRemHvQ_EpK_tamE
    AEvYyDQSFogS1bw0n0>
X-ME-Received: <xmr:_ckVYcK069lDZywO06tsKOa2UqjosIyNtPqhbaFHUJ0-eBFI0VOgpTu_0BSTmKSOex1hlsm03Hgo-s_oN25neM4onppOhkqiVsQM-wfEMp5XEW8ofg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeeggdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefmvgcuffhuuceoughukhgvsehnrghivhgvrdhshihsthgvmhhs
    qeenucggtffrrghtthgvrhhnpeetueetueffvdeufeevhfdvgfduhfegjeehkeefffdtle
    eftdekkefgveffteetheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpeguuhhkvgesnhgrihhvvgdrshihshhtvghmsh
X-ME-Proxy: <xmx:_ckVYcGufbFZswaa89XWtkpQL85AmdaeIcx0EkwLxmAhgen0eMXavQ>
    <xmx:_ckVYYWStDHVP9YgEG2ui5hM7QSxgPB2SRIRPB4UDur0nOKAX-6RSA>
    <xmx:_ckVYfN8CE-v1Ii1BLohV69REaZmiu3ljhVhjF_uUYB7DeISyLoObQ>
    <xmx:_skVYTdx-SyaTlJXsFdzplHRh1xjj4KNw1gXMS6Hj74GfrpxmtbAMA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Aug 2021 21:25:17 -0400 (EDT)
From:   Ke Du <duke@naive.systems>
To:     luc.vanoostenryck@gmail.com
Cc:     linux-sparse@vger.kernel.org, Ke Du <duke@naive.systems>
Subject: [PATCH 0/2] fixes for using sparse as a C++ library
Date:   Thu, 12 Aug 2021 20:25:09 -0500
Message-Id: <20210813012511.65397-1-duke@naive.systems>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210726182822.ylmd3vtm44txowoi@mail>
References: <20210726182822.ylmd3vtm44txowoi@mail>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series contain fixes to use sparse header files as C++ libaries.
Please merge your previous changes you sent first, for this patchset
depends on those changes.

Ke Du (2):
  expose more functions to C++ in header files
  make implicit type conversion explicit

 lib.h     | 4 ++--
 ptrlist.h | 4 ++--
 symbol.h  | 3 ---
 token.h   | 5 ++---
 4 files changed, 6 insertions(+), 10 deletions(-)

-- gst
2.31.1

