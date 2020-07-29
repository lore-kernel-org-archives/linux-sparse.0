Return-Path: <SRS0=pmk5=BI=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D238C433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 29 Jul 2020 22:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B582070B
	for <linux-sparse@archiver.kernel.org>; Wed, 29 Jul 2020 22:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qbsx6vJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgG2WBy (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2WBy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 29 Jul 2020 18:01:54 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70259C061794
        for <linux-sparse@vger.kernel.org>; Wed, 29 Jul 2020 15:01:54 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id v22so7727426edy.0
        for <linux-sparse@vger.kernel.org>; Wed, 29 Jul 2020 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QVQosifzgqmjsXbSu0Ol9Hz+erSZxWbdxQnftGUpu7k=;
        b=Qbsx6vJ3fa7dL8IbTIEQ+g+bzrFlR4x10XDhQP4bayTqt/wTawjX1cAbgqqILrOUaM
         rwLqqUCyCTaWeAgodAJQdGii5/MXTudsQm2+E14DP+aiew1JwQGoxUl38HC2f3GRVVwZ
         qpTxxPPNPuibrnXuL1qvQ61Q6tQEW8qC14/qYKgm6PfK0UcSwNUzV9EFdr4KwTuRi/0+
         oxoX+Ny9PZrVJrJrShLEEkYauBoyuDrKMzouPQSwkfR6werg7c06l1CTEBk2lrkQbjTF
         eBbq9LssX9M+1LzdU1VbQWPrwh4dq/Tluqkq9EBum5maco3A9I0o1g0/gsH3C2ZQhno3
         DnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QVQosifzgqmjsXbSu0Ol9Hz+erSZxWbdxQnftGUpu7k=;
        b=lj/m6f0D9xEN4YYVLcVF54s8uDKlYxWejIi3jTzD/pkFumtu8BIIthzTLMFfK2KkAe
         b82YL/qZcqquZ1AiT6WztlC1nXzqqHWFjDYADTBZczmOaV/21gt8tS1/x2Je007o8dLz
         CPsuJgtRd/9Tj2pDYxJsp5I+AKpfdH3Y4qXB2N3p/NbAv1Eb2Wcn594/DMX8ZfruXIuY
         EcaV5uFwMKw+zAqDtMCkrM2/I2VfmiezUsI6PUzHqnOjBU710/lhEdMp/PBNNCVTE4Ld
         rlSsl3rfkNlth2r3D8rNtUr3KRhkc0OHTqf7n7jrvmYTqeSApADzgQlKp6e94Up8+KGA
         ul4Q==
X-Gm-Message-State: AOAM531GjlvJDnI6N14T4JYWUbNCrs/TIm0qYUPtv07J4MVp8/SYldMU
        lBEoI0bLrq58I0zhVvAEsbSqZp33
X-Google-Smtp-Source: ABdhPJywHmipUQLNMNdDDA6kAXIkRHkjHRzWHOzPPz4IlgmsIS2yaYEuBZLORIgRIBKZJu0aWvO5Zw==
X-Received: by 2002:aa7:d410:: with SMTP id z16mr293717edq.287.1596060112955;
        Wed, 29 Jul 2020 15:01:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:1901:d1e9:3339:2ae])
        by smtp.gmail.com with ESMTPSA id d20sm3197134edy.9.2020.07.29.15.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 15:01:52 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix stream_prev() for invalid (negative) stream
Date:   Thu, 30 Jul 2020 00:01:49 +0200
Message-Id: <20200729220149.96272-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Now that the parent stream is stored as a position, the validity
of a stream can't anymore be tested by checking if its number
is non-negative because inside a struct position stream number
are stored as an unsigned (and changing it to signed would halve
the maximum number of stream).

So, add a check against input_stream_nr before returning the
previous stream.

Fixes: 4c6cbe557c48205f9b3d2aae4c166cd66446b240
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 tokenize.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tokenize.c b/tokenize.c
index d68fbcd8eebd..ca842f52882b 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -66,7 +66,10 @@ int stream_prev(int stream)
 {
 	if (stream < 0 || stream > input_stream_nr)
 		return -1;
-	return input_streams[stream].pos.stream;
+	stream = input_streams[stream].pos.stream;
+	if (stream > input_stream_nr)
+		return -1;
+	return stream;
 }
 
 static struct position stream_pos(stream_t *stream)
-- 
2.28.0

