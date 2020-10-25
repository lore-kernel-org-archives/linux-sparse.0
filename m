Return-Path: <SRS0=+N6z=EA=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC21C388F7
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 13:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948622222F
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 13:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcdgLqCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416174AbgJYNJ3 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 25 Oct 2020 09:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416173AbgJYNJ2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 25 Oct 2020 09:09:28 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114CDC0613CE
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 06:09:28 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id c15so9609214ejs.0
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 06:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=934SUTTvAe+2laGy0mD3l9NmxFrowDgS35VikC9JNh0=;
        b=UcdgLqCjLTr2oxolg1XMxywQW9G74vLe60HI4A45ZxiPEoxUR9xMjUzii0DW7lpslV
         Da0uGegTnTeSRBFGWLY6/clfyjX2UOR337z89fI6ARDZMUStT8bm8bDp+6lQCpAB5CUW
         EsRGWiKuWuSLboFqk2uu0KiuTImi2dBSGnljNkWFS7bdvWMVcRggXkSOvF6xlUthy+Ls
         CO0NnNXXe7YFUIG02y7RpkNflCniAgzE7NKTl4mkXCV7eKcxpHTBQgzoXfKYujIqAQJ8
         WVKV3GVwmZqEIF5xRN0L2h1WLOfZMLIexcbNyb1zoG84Rm+lWEDyoAKSnJa+nLxkqRzt
         ZG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=934SUTTvAe+2laGy0mD3l9NmxFrowDgS35VikC9JNh0=;
        b=U1OaocXa827IvhXZv9XGgFMnBgF0At0CFSl0MLX+ASSgSG/jANti5FOWKfKCFTLtA3
         ONg6mGc6pcd8mZeGUaSBenPZjUZ7GnJJqgmY8naRx8DEPQzUXZbvEU6PhvOccrKgSZEN
         9fCORU22dIGDlVZVE1GZkapIhAp1exsh5MljJ0Ty2AhDH1c7hNw7FyZvo5P82OvMhJt/
         wxYOx+ncs9mMAlpYoLwY2KpOxmzRA1CSGXpqsXHAVB2ZKj36oiO+6NX6uQPeqpLzHOUj
         ZzY4qBliktcpre3aqplIyQBKN6XZmrOjBsTIUvfZKdDt9+/2sF/zPu4ixh5Jwa6YwjMS
         z49Q==
X-Gm-Message-State: AOAM531KWAIdvYwG29G3oflZenc5sWg2rm24lJB/a+RiAedswe3d3KKo
        T8BMiMrStdd4OpBZXv5u9N9TPc9+r7U=
X-Google-Smtp-Source: ABdhPJwRPQRx05MwkrbHbEJqIi/vPjF6+3F3p7MaLFmPX36U9epUy559J7uflod8RwgJlfDUgxwd/w==
X-Received: by 2002:a17:906:1f42:: with SMTP id d2mr10858364ejk.407.1603631366430;
        Sun, 25 Oct 2020 06:09:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f136:83e9:1c3d:13f2])
        by smtp.gmail.com with ESMTPSA id q3sm3571350edv.17.2020.10.25.06.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 06:09:25 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] fix testing if a OP_CALL's function is pure
Date:   Sun, 25 Oct 2020 14:09:19 +0100
Message-Id: <20201025130921.20693-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

kill_instruction() will only kill an OP_CALL corresponding to
a pure function but this can't be testing if the call is not
done directly via the function's symbols.

These 2 patches fix this by using the function's type always
available in the instruction itself.


Luc Van Oostenryck (2):
  add helper first_symbol()
  fix testing if a OP_CALL's function is pure

 lib.h      | 5 +++++
 simplify.c | 6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)


base-commit: 8f7e21cadc21f49819d003e560d4607d720c647f
-- 
2.29.0

