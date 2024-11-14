Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D34E1FA823
	for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579249; cv=none; b=LSZD0D2eJupx5cMyOMCttLkUd7IkvA5h+gG8Lf1pTxJyjg0Azn1qcUSWCjrmQiInMAHdaRhIBeUPA95zhzKZJA23vWYArXHWNyb6XmkwFVWyNFBz1JihmOQZZJUvncnfxhz2AWSC3SCDCBdABZgGj+cDSlQam4dSHnIJnP2psBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579249; c=relaxed/simple;
	bh=LzXQqpEuqMmSUJxm/liNxfQnP2SfNO/MZC1JIv85GOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J7DQXDRXu60xMqWrcW6Uv3vkBB11WN1vyC0HC2T9vxt0S+izTSJsK0ufLERogQ6OUwIWT0QG7GJ5Peqo2NV71Eb1k7NJr41UQpItloYNERJqTQKHFgd0+N81B44cHy8yrpPK4tLX9HRAKlgnvEPz5pwehVlCjaWBsum6il1QipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=kFX2Bz/D; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="kFX2Bz/D"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so30007366b.3
        for <linux-sparse@vger.kernel.org>; Thu, 14 Nov 2024 02:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1731579245; x=1732184045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ/zrN5sRtBVMflm7R+qmiosmx+ZNNh9BpAvkYEZgcc=;
        b=kFX2Bz/DMOe8Jn3Kh+Oz5s3J7cRspAkJwiNiX9/hZ0O0Z9ZJfy8/8z2TJZ7b68lRCc
         yGQ6LeOigQG63AuHOcAAHUfDFKfNuQzDpiStugL855EKzt0Z760m7PKWFM4VZ1K8Fuut
         ESJ6Jk2Hl1Alj3rHf6OaR7reFBCZ9Dm8eQgalpYBNtfZ3zJHyDlKKNy7/pKYiTbkyqEX
         AYlso8f2FSNcMSZC9BG4Bqz6j5jWW3ThmsadkYJ8acpgvu1TsKxLZoSXyEkSvvbqbozV
         FaO4OA1QdNB0ucKAUR2ZrqXRwZlge70pyQEw8a5ea+dAnKjsKSv3GleMx/NW5722ulRs
         a69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731579245; x=1732184045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQ/zrN5sRtBVMflm7R+qmiosmx+ZNNh9BpAvkYEZgcc=;
        b=NvYA1tNnaHNW9EI8yL5AJTfKr+kSi1EdyJF+oLyEO4PZZ7My6xQND1dayLwwZnAT2u
         vrhyx2Aku06JGA0Aw2AslCBjLVyxXMoXpNVJ00ixKQKZssHuPtiPRsDm9yaW+FFMoFHG
         S18G2gzJDlrvxfUWVDUWsgoewTM41WGmADQ0NJvOtQcX/d2SkybqlnE5iYtc2whmblkH
         vAy++ss6gMmzX/2b6bLcKUeImr2F+UiK3jZHjAH2jLP9m858oWHxqvG2Mon6qKoRU5X1
         poHcCKCrcnNqZZ6Xh21g51qvSCRGy+zb6MOufUQO/4fYq9n5bIEqOVV3D5Wz7lXUsPpg
         0kvQ==
X-Gm-Message-State: AOJu0YzUREerRINmjv9ODIWR9o596nZ8rpfk1UZQYvcDyYYUqhLOAejW
	iwpCO0W7zwm+VA4ZnfsttVY9eyBn9MezEx20BB48FVICmZyjdtuIb6YA+rojbkg=
X-Google-Smtp-Source: AGHT+IFOIdhn+CO79i3SGeWv/TK5AejMCKm/AqH6QkLNChISb6RWLQC6we/lH0D4AeOxkuY6Je35/g==
X-Received: by 2002:a05:6402:51d0:b0:5ce:af08:a2cd with SMTP id 4fb4d7f45d1cf-5cf77ede3cfmr2170100a12.33.1731579244701;
        Thu, 14 Nov 2024 02:14:04 -0800 (PST)
Received: from ryzen9.home (193-154-230-113.hdsl.highway.telekom.at. [193.154.230.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26c84sm46139066b.35.2024.11.14.02.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 02:14:03 -0800 (PST)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Add missing include in compiler.h
Date: Thu, 14 Nov 2024 11:14:01 +0100
Message-ID: <20241114101402.156397-1-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A compilation unit that only includes linux/string.h runs into an undefined
BUILD_BUG_ON_ZERO(). Fixing that.

Philipp Reisner (1):
  compiler.h: Add missing include statement for build_bug.h

 include/linux/compiler.h | 1 +
 1 file changed, 1 insertion(+)

-- 
2.47.0

