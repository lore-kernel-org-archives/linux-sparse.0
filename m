Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FABC1350DA
	for <linux-sparse@vger.kernel.org>; Fri, 16 Feb 2024 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109077; cv=none; b=QP9gkVeMXCCU6c4Mef+2h68zCLCN3XXo/pnbtrsrBNk9wb9JDyZueIxQv4fSOEjPmKESXYdx2h6LltsByDVOat8CtRaVt+0FGw7rTbjVJNhu+HNHcGimW1IoSvxTBTjaLhYsWGL4v4PcbGbMgX+7QExzTvzwq8W6uebelmvWmio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109077; c=relaxed/simple;
	bh=RxSvM42ptBx1y8D71rdVpJdsIr3A+SJ8/+vC6w0mZNg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oDpATlil8sYL/I67AdeniCqXEVcfKlNjp5AYFLgIHMlvIxN0QGfs4TeSwi8/MMDli5AA+pYeSnicK4p6cNIOvN2qERfDYVSFJQ6lS+IqpcSqaSIvuYH7s6++roJ89flSd4QhTbRoSm9mSI23xLGJ5UbNARD479j0FnRCaZW9YEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvECyugS; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvECyugS"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d10ad265d5so14575661fa.0
        for <linux-sparse@vger.kernel.org>; Fri, 16 Feb 2024 10:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708109073; x=1708713873; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hP3FKG7Ee7SjeEbNeOAgsR2xkYncynbIig6BNw0KceI=;
        b=hvECyugSgmOXWtjU2nEdVmgYgptfiF3RFeTBwvwE2nL78D+HlXJbNKh4+AlhPvz5O+
         sKYtizewGRTIu1IPz9LFdf31t+jqf+1QEySUgwl+XRk2Wj8lX3enHkL7l8/NNRciZaRL
         pQqp7gq/7BwORgezjrMzJnj4fP3jhgEoKjS/aUR/ef6yrKn0lXFr5byMyXatPVzTH7N3
         DHUcgxhfOFnpzU7JGc6KoOYiG3vsuCzzWGEYnNWMgBEo9h2HM+qU9mDl+lorFaLYuIUs
         bvmIMO/hiu7fQ7DjYzdqy3KpHdyO/5yAz2NXz4R1aQxr4TRyqphjyKvaYgTi9Wsoa8+3
         PwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708109073; x=1708713873;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hP3FKG7Ee7SjeEbNeOAgsR2xkYncynbIig6BNw0KceI=;
        b=F5O6d7cF5KZaZ+aot2UlJpprNJ6Ei3ZSzYWMlTsfcWZPxyKHCuN6QW5D1nLnqsn6/B
         N6IFrZhCxxbBEN9BFYLIhJRHIwQEGAieb4MKoXep7BDlFTHvkCm9vL/4fob0tSGmTnk8
         Q08p+WlD+azNafgAIDhQ6aXU/tU0suB/XsjyL7FiFmSsR6SEYjsbcWHK6Ir4tBJNRUvQ
         NVvx1pvhfxXapeWBMpiZbe6GBJ9KNWHJJGfAyRxuE/DWXI82E/jl7CCGCUVSMGYuSmLB
         ul0B7D0Gr1GiDA+s8s4apmDBBEomNDDKKJrWHwp1a3oqR6FyE24y9UIEqwh6ClARHaMk
         HYUw==
X-Gm-Message-State: AOJu0YxjXTIrpvK51X6H2KrnrK8dX8a1jqAf735/WrXoIcqHT8UYy/fu
	ud13cn8PHccVXQZMiPFcfUp2MdM6RlHIk+PqTlr233pLxZho9aE=
X-Google-Smtp-Source: AGHT+IGItgl8srFdT1ctRVDNnEmcTJIjLboDYc68aSxJbErb6Pa4ZQHzZ78dOwQae23MAf3nv77PyA==
X-Received: by 2002:a2e:9607:0:b0:2d2:1107:3a3 with SMTP id v7-20020a2e9607000000b002d2110703a3mr3402301ljh.10.1708109073200;
        Fri, 16 Feb 2024 10:44:33 -0800 (PST)
Received: from p183 ([46.53.252.171])
        by smtp.gmail.com with ESMTPSA id f5-20020a7bc8c5000000b00410bca333b7sm3021918wml.27.2024.02.16.10.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:44:32 -0800 (PST)
Date: Fri, 16 Feb 2024 21:44:30 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org
Subject: [PATCH] fix {pp-number} ## ...
Message-ID: <d67f161a-acb5-4cda-a51a-69a4178e9c9f@p183>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

pp-number token may have arbitrary number of dots after first digit

	pp-number:
		digit
		. digit
		pp-number .

which means that merging any pp-number with ... is valid operation and
should yield pp-number:

	#define M(a,b) a##b
	M(1,...)

should preprocess to

	1...

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 pre-process.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/pre-process.c
+++ b/pre-process.c
@@ -482,6 +482,7 @@ static void expand_arguments(int count, struct arg *args)
  *  - number + number -> number
  *  - number + ident -> number
  *  - number + '.' -> number
+ *  - number + '...' -> number
  *  - number + '+' or '-' -> number, if number used to end on [eEpP].
  *  - '.' + number -> number, if number used to start with a digit.
  *  - special + special -> either special or an error.
@@ -524,6 +525,8 @@ static enum token_type combine(struct token *left, struct token *right, char *p)
 			switch (right->special) {
 			case '.':
 				break;
+			case SPECIAL_ELLIPSIS:
+				break;
 			case '+': case '-':
 				if (strchr("eEpP", p[len - 2]))
 					break;
