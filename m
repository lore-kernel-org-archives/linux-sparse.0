Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6660C433F5
	for <linux-sparse@archiver.kernel.org>; Sat, 21 May 2022 21:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiEUVXa (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 May 2022 17:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiEUVX3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 May 2022 17:23:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC49629802
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 14:23:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id rs12so9877261ejb.13
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NZRl9WfAi8Hu5aZvgMi6HmqtL/sno/YXJR5gXhDUgGs=;
        b=j/rjDl32tqK3aorSjmLLrMXEqFnq/uKYiBpVmy0tQvlT8cMhmvC8llr89kD8UqhVZ7
         4R8XIiPR5wpyJytoOJzV5UlJfT39+VPZMNzWVADDqskAlPWKaUCeqo4jv/2A9tbn8Upb
         FcEU63SwLjtZD9FTB1zmyVmYxydSDraIYUnBJOsZYHcz3VI7ATCYooT6j7hrm8XcJu5P
         OlaO/EoDYIcTMpmSzvB9w9me3tj2Y6bOdZh4U1I58nkXlwHIud55Wk7dpP95zBCPPXqp
         Yxwefh3x/HMesohQ3wX8vxmkbZmo3pJJJEXmjcKPRaw/7nNhieZFfTvXSwbg5Tbf6ND1
         jxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NZRl9WfAi8Hu5aZvgMi6HmqtL/sno/YXJR5gXhDUgGs=;
        b=7Qo7r2SiGCt6Txp50jdcXD7bG4WjQq9lDh9kKRjlEg21mT/c0ZkCzPlXVk2zYuEt8c
         hb4w5VIAmUacQq2e9oNtoyV7mvv7TTjrsy8FUAqnnGPYO+LCm5g/g2v6sXJRhK0J0GXG
         swCFXPtY71VbCaoQCStp34t83SdK5clSv8OA4g5vVGwml3CFK2anktOO6BjNCfW0rvz6
         gGghgf0YnBCcmeMPA9U4PJgNoNVYS9A7FIN2R5G6x8CygsBc5ABbc4uJ+qy9j3MVK4F7
         /bbtwkyLGdTdViv+cVqe0WvZ+A6CsJ0qraElM2ghhmwNdOrwUMTZnqU/eDFDVLR0l1Bc
         vFVw==
X-Gm-Message-State: AOAM532Ab1xU9BrO2E0cqOJR1ibAHrNDMmKhDIdYTEXo6GDdlXRs/Gj0
        gLrSnfy+0fNm+v4onJ31q0c=
X-Google-Smtp-Source: ABdhPJwCEIG6Kdp76EUWhdjQ8pgPyFpcWSsQ1SJ38+Ub5NKoff1IYpZz4QW7Ui3+Zq2WDAf0/2yxBQ==
X-Received: by 2002:a17:907:7e99:b0:6fd:c2a2:9620 with SMTP id qb25-20020a1709077e9900b006fdc2a29620mr14591010ejc.554.1653168207292;
        Sat, 21 May 2022 14:23:27 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id ca7-20020aa7cd67000000b0042617ba63absm6035708edb.53.2022.05.21.14.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 14:23:26 -0700 (PDT)
Date:   Sat, 21 May 2022 23:23:25 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-sparse@vger.kernel.org, Kito Cheng <kito.cheng@gmail.com>,
        linux-riscv@lists.infradead.org, mkl@pengutronix.de,
        aurelien@aurel32.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1 0/6] RISC-V -march handling improvements
Message-ID: <20220521212325.lw6fdzsmlwvioggv@mail>
References: <20220402050041.21302-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402050041.21302-1-palmer@rivosinc.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Apr 01, 2022 at 10:00:35PM -0700, Palmer Dabbelt wrote:

Hi,

Thank you for these patches and please accept my apologies
for this much delayed reply.


I've just pushed the Zicsr and Zifencei patches since these solve
an immediate problem and I've some minor questions/objections for
the other ones.

-- Luc
