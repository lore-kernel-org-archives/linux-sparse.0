Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A5290DBB
	for <linux-sparse@vger.kernel.org>; Thu,  4 Jun 2026 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580451; cv=none; b=RYT5K4L2qqliK97owjfFsSU4jlejSjB04pcIUtfWHbv4rzF84mGdssEBog7ptVSWTY1JugDC4DTjPcpRWqJwLgjRCqexu4vWTI0tQN/uSgZCTzC44cyPuak8VN0HSyhH9ls7mFh+ti/3baP0/fPXhm8HOxYCMAxBmCJZw3OZJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580451; c=relaxed/simple;
	bh=Ia4ZkqrvAuo+2JUZYI2JP7DR/xb6tfitcQcKFwPPazg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nfPPXDT2awkOkQe+7QuolUoCAwtXmSWevEmqzOpHpQvZ1/MqrQk/p4qkP6UMAPK7/vdyKkCI4FGCl6jqY84SotKmlL/X1qZUj0Tr7D+Zf1Hr6SrH1kURUZ4v7Atxprl+CrTUBjK22i62ZpPcNlpcpf3iiAUhs5+FZmwRQXCHGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faJMPR8k; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faJMPR8k"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso8946885e9.3
        for <linux-sparse@vger.kernel.org>; Thu, 04 Jun 2026 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780580448; x=1781185248; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sL9neyyJBz6F+DZRLOdXJQRubtqhmEOqq8YYKOms3d8=;
        b=faJMPR8k61bHA6jHArCZbVKWIJBIYylAFw2hy0vRgCvGN7IGYdXkz0mjLpcKFrSYvx
         KxNDif9tubqAH3MxQ3/oajTodh8yJN2O1RpR3uoIKFuRCRcFSFoeQ1lBH2F3HlFdQCcS
         NZVtYkKnzfCut9OqA1sJHar+llVbR2earCc8Tq76HK4B9G5neEFmx55PG4UqzRLuWr9d
         dm3zv0Yr3xkiCDaGbLuHS0fZNlWSl+3ZV6iSe1zB8h6/z8b1a0Ei9nJ2KAJ5V+jR2x9s
         chVsg0XEDRfKKxfsW2TxzUMILStl8bJ+oVDy1kNKY/3rcL9Q8HwbXowRAE9oCooXivfV
         wmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780580448; x=1781185248;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sL9neyyJBz6F+DZRLOdXJQRubtqhmEOqq8YYKOms3d8=;
        b=AbPNputF/TghuwnA5BEvlSsgY0OeCAzPcTqJJr6vBw2coPM5TdFtmlWUFPxJ7SAtS9
         Jeitw8o1Lsxu7a/KJJ5GGISQsZcyeUECOhxjauG/E/ozNFalFngo//AKa+ApYNdojCNj
         9DPrC4QrWxMS++MFw3PLv7/KaDmdRkmkRl1yq1iumvq0Cldk42x1jRSZgXlKgY6ebAzK
         3ZBuvmTJIvPgRjc4z1KGKlALJ5wOWaYYqR6OuqSKJFs1WyBkMNDSJ76bn5ZveTD34vaa
         UZEL7Bz6AIAtnlLIPEWtKhMdRtzPeJx04jfjEUbOdGACg8G/AdbFd2A+eYBPnrser/i1
         u9PQ==
X-Gm-Message-State: AOJu0YyQfmy/QCUFohappSJzNvIIYi/tgcMWdC+0AlvkkC8Nxnejz+K8
	ZC7WT6XgKYr+MFXF8owySQPJ953fQ8SYdhPLzSPynMR0yKqD6xav6y4Y9lEqRJli
X-Gm-Gg: Acq92OFq7XTrCrQ5Ogr0Unk8TBfLLebnxE9WjyicE/hJjbuvmjLgW5u+TcoP8B4+3cT
	7XmPfEe+UcIY6SX8HSBobqSVyHtRmuio+o1XytWpu6gGnka5dgIr7dnv4Q9/L1IjysvAZaQin2d
	EVr1E1q3rfRAzHKXDHgJzABVHoYBrw84YRlxKTDZTpJzzMnkZMLok10KREbm/O3A0R09FCNCqQD
	r0kJDZPOdx9UTbFfzUNgaHaDVWR8T8TaY/S6R/uuVbHPvT+6S6JEbtpsNvWw41YEZMbiggcPQic
	ItLHLNq49uQKaILheWDpduK7rZ6v8WHXvnpQWwXIzgaoU3Wi3VBFK3ORu4m/xPooYkJ51n6EFTD
	kqV8XUWyNSidnmGt1Ceqesf93yRjqVI+hp4R0aGtVWkZZtrNix4YhXACH3Boxx43lWY1dqDTTSe
	edjg3k9i1j0CP53kC+mYC/n+ogNZIB/g==
X-Received: by 2002:a05:600c:6092:b0:490:b3fe:9732 with SMTP id 5b1f17b1804b1-490b5ec3f9amr134461945e9.16.1780580448070;
        Thu, 04 Jun 2026 06:40:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7a6efe0sm100659975e9.1.2026.06.04.06.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:40:47 -0700 (PDT)
Date: Thu, 4 Jun 2026 16:40:44 +0300
From: Dan Carpenter <error27@gmail.com>
To: linux-sparse@vger.kernel.org
Subject: declarations after a case statement
Message-ID: <aiGAXJhYJoUuqB5j@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sparse doesn't let you declare a variable immediately after a case
statement but that's something we do in the kernel these days.  The
"b" declaration is fine, but "c" generates a warning.

regards,
dan carpenter

$ ./sparse test.c
test.c:10:17: error: typename in expression
test.c:10:21: error: Expected ; at end of statement
test.c:10:21: error: got c
test.c:10:17: error: undefined identifier 'int'
$

#include <stdio.h>

void func(int a)
{
	switch (a) {
	case 1:
		printf("hello\n");
		int b;
	case 2:
		int c;
	}
}

