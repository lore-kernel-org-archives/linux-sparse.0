Return-Path: <linux-sparse-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C53C77B75
	for <linux-sparse@archiver.kernel.org>; Wed,  3 May 2023 15:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjECPcf (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 3 May 2023 11:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjECPce (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 May 2023 11:32:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324B35592
        for <linux-sparse@vger.kernel.org>; Wed,  3 May 2023 08:32:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3062b101ae1so2755930f8f.2
        for <linux-sparse@vger.kernel.org>; Wed, 03 May 2023 08:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683127950; x=1685719950;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SU9RxfazOghbsFZdmv9Rm/1fWfFP+Dx4yN1sdYemBKg=;
        b=nVbs9uWGSX5vP9Z4UcJjCsjbB+DfyCSyUeHZZiZNuvwJeyEFfP1ru3aJOfZE8i8kCq
         NUrEJf34a26wg/tadtFhWd2u2EGIsu08XAr+nNoRRZLkyHlZHAQCLdoRlOe0Lodgp+4l
         2od9M+pieoPloHnwFUxtQMWd18YXTgcb8J5BEXVNjEmAhx+/NCYXYQ0TjedeTURqp7uO
         Vrqz86FXnmukK6tDEh8HIr4d2aVbq8AaS5QsP+440en9qBwi6pHvX+MWKVV6HwDKr3Ib
         m1WuOAe4uD0cR+9hlqUQ83+eCK1d9CDlA1A2ldXc2cSK6hLuI1gpelydvoAo5hcaQyzC
         dv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683127950; x=1685719950;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SU9RxfazOghbsFZdmv9Rm/1fWfFP+Dx4yN1sdYemBKg=;
        b=V+nnIjjI3+bo/sAGS4rCZgbMrtQ85kht1Lx+BsGWNfR0/Qqp1A8Ii3iXE2tdIaRsZP
         nFFSguaTp8D6APIbI36MXA50XiWcwntIR6qWPg0VxRsfGWj9i77XNz1XL8eDhR5g0wvc
         IxxFOWfwErIpdCHByVUOYsInukC3ziYILZdxmvXa5i9jvuaMg6lf/qmnBXe3FsWJHGWs
         WRrOeqUJPxFHG5gNjvu2EQ7znWKceR3RuR8vo16mwJzuIzh6Y6ESzQuavDWpbg1hoEfF
         GRrDiZ2hcXPXBzkW75wptnwaqf8NVDLfBCT0YMDNELNHta2wE7rAel4q6UlE8Z9Q9P/9
         vySQ==
X-Gm-Message-State: AC+VfDyA1OdQGvOAf+68JVUMNhyAEAimM/Fc74I7tJVOk1rhVQiiOQ9k
        QU83Zh6d0yLXF1DcfoBaDUOhtGSsPj9UzZozyuY=
X-Google-Smtp-Source: ACHHUZ7gjz85VLh3bMaa/iJsGGCCfbsFynfp3alj87H2OvuHETImhZL0pwbWBfal+SICMEBQGqF9gA==
X-Received: by 2002:a5d:5918:0:b0:2de:ffec:e48a with SMTP id v24-20020a5d5918000000b002deffece48amr316366wrd.29.1683127950582;
        Wed, 03 May 2023 08:32:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p18-20020a5d4e12000000b0030647d1f34bsm406021wrt.1.2023.05.03.08.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:32:29 -0700 (PDT)
Date:   Wed, 3 May 2023 18:32:24 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     linux-sparse@vger.kernel.org
Subject: Sparse on ARM Neon intrinsics
Message-ID: <f6adc14d-c5c5-45c5-9e85-979d5d328842@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

There are a couple files in an ARM build which fail because of ARM Neon
intrinsics: lib/raid6/recov_neon_inner.c and crypto/aegis128-neon-inner.c

  CHECK   crypto/aegis128-neon-inner.c
crypto/aegis128-neon-inner.c: note: in included file (through arch/arm64/include/asm/neon-intrinsics.h):
/usr/lib/gcc-cross/aarch64-linux-gnu/12/include/arm_neon.h:40:9: warning: '__Int8x8_t' has implicit type
/usr/lib/gcc-cross/aarch64-linux-gnu/12/include/arm_neon.h:40:20: error: Expected ; at end of declaration
/usr/lib/gcc-cross/aarch64-linux-gnu/12/include/arm_neon.h:40:20: error: got int8x8_t
/usr/lib/gcc-cross/aarch64-linux-gnu/12/include/arm_neon.h:41:21: error: Expected ; at end of declaration
/usr/lib/gcc-cross/aarch64-linux-gnu/12/include/arm_neon.h:41:21: error: got int16x4_t
/usr/lib/gcc-cross/aarch64-linux-gnu/12/include/arm_neon.h:42:21: error: Expected ; at end of declaration
/usr/lib/gcc-cross/aarch64-linux-gnu/12/include/arm_neon.h:42:21: error: got int32x2_t
/usr/lib/gcc-cross/aarch64-linux-gnu/12/include/arm_neon.h:43:21: error: Expected ; at end of declaration
/usr/lib/gcc-cross/aarch64-linux-gnu/12/include/arm_neon.h:43:21: error: got int64x1_t
/usr/lib/gcc-cross/aarch64-linux-gnu/12/include/arm_neon.h:44:23: error: Expected ; at end of declaration

Neon intrinsics seem really complicated to handle, but maybe there is
a hack around to just silence the warnings?

regards,
dan carpenter

