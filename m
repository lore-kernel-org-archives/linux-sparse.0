Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E274311964
	for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210302; cv=none; b=LDwKdKY3jGIBvHf/MdLZ08fJZr0bmOCKfBXA+VAJO05NgeNL3KQilNqv+U9uRNe944UN0cE3dxkYn9HCm0iZenvESn55wmcv/IYxVzM6+8MtQifdwZNzXqFaPuQHqS2CIV+RcZ71v8b+ylxDjn3fDLREA8LIX5YQPyUImYHnn5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210302; c=relaxed/simple;
	bh=LCEdDbRbEPo3BklIUvSAGmihyIaVBljZHKIihFLu7bQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=K2f0jQWgkFFroJ+5EfIQATWLUKSAAaJYLFycgh1qDOwXeA0sSJ2cqq0sDJKzeBNIx+Xz8/7ugxLA+91wJdd5uLn8ALzsbGAt+aiC+8E8qeaoGVJyUna4NmAkToMpeVUwDElcdwL98EIo13WrDz2zTJLxrGmUywbbbFLBPPNjC7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6241ab7fc41so438206d50.2
        for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 08:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210299; x=1758815099;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9/xuzUuOfOJLkcPN2kNbunt3HY4sTAtBaVdykBHeac=;
        b=AY7o631UJ0lOjV54wYVYMQ1Yk9AU7aETc37v3wzqi2DOEnfwJ0r5Cw8oCzjCm1EzJR
         aectRzeCZJdkxTrC1Xo9DpeWzk3psilL9HKOv+zvUn1Le7FtGS4EVs2ypyMOITJfGPbY
         2+Jvv5aLnlDsQDuNlM/tiJRu/eEGZuJzdVVVgNknZMZQqhfYLgiMppGv6GranHo3HNGX
         DF1p4UbyCCY9HVJqKr6Jv6UDGdx5S558YHvFaNALAE1+lKZibJ7Ie2H91sNFV45CvH6w
         9u35r7pOtqAFZb2HtXSf6YIAKGXIhWtmPkkWNW3ZwsXfIdKi8CqUAS9Y9q13UhW3fBt/
         lVPA==
X-Gm-Message-State: AOJu0YyLaeFcebOlG1k50B/gs8fHJHsBB6Wdt1Rj6/lGeHJKvuOK0L+e
	b14qbZS44tU0ihw1xaqCH4eG3qedHmwXgJlmqwJAiyceGbcHtUbtRU+2oz/LtsF+fRsGvpVbmY6
	dqPy3eN2fjMeA+eRLIOPEXbXCJGAESfl5fWP6dHeB4nfEcORXaBrWOYt4FA==
X-Gm-Gg: ASbGncuZiUP500i29tdBFS/L9fCf9kN7bpNN457MoMRrfP0qDy+Rur7BsnAJ5g+sHYA
	5CrGSP/cqhGv2tAmvgz1cv6I+k94BN2u10z6FQDKeHk9386+YeeqpOonExUAGlBPrINykTs2tvA
	gki2GYwCstrZS1iHl1lgIbbGCEY5+cofYLJhbW6BS7jNul9EeaID3qIRmBUrSzrHOO/elIx733e
	rJWsKtS3T3B53plbIOCb1tv
X-Google-Smtp-Source: AGHT+IFV12SHd+jhPVdzsXzTEOX0xuKnH0+D2+zoInpZMxl12iJQRlpostvZWvwviMNXQ5l2H0KMCBG7f9gNmcnQ8aA=
X-Received: by 2002:a05:690e:124a:b0:629:b4b5:6267 with SMTP id
 956f58d0204a3-633b07381e8mr5701915d50.26.1758210298832; Thu, 18 Sep 2025
 08:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Li <sparse@chrisli.org>
Date: Thu, 18 Sep 2025 08:44:47 -0700
X-Gm-Features: AS18NWCi5E5nv4ppcUVipQpHC5cwajE45fjha9-vFPop4s6XuLxBtgL1wQgL-0c
Message-ID: <CACePvbXDO1ZybDu3RaFhED9D-9gC6LTMpWrxoh5xD+ZO5SLdzA@mail.gmail.com>
Subject: Sparse maintainership
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Very sorry that I disappeared from the project for a very long time.

I was the sparse maintainer until someone really wanted the sparse
project maintenance and fought me over it.

I was deeply wounded at that time and felt sick of the situation. I
pulled the plug completely, I stopped caring.

I was afraid to click on the sparse mailing list folder, even though I
am still subscribed to it, like a wounded puppy afraid to lick the
wound. I can observe the number of unread emails in the sparse folder
is growing, I assume the project is doing great with the new
maintainer. I am afraid to look inside.

I accidentally clicked on this folder today. To my surprise  the
project seems unmaintained.
That breaks my heart, again.

I would like to get some clarification on the mailing list:
Is the sparse project still maintained? I really don't want to step on
anybody's toe.

If not, does anyone mind if I slowly resume some maintainer duty at a
very very slow pace?

I have much less capacity in hobby projects than I used to nowadays.
If I ever pick up again, I can't promise any capacity or SLO. It will
be my own very slow peace. I just feel sad to see the project I used
to care so much got unmaintained.

If there are any objections, please let me know in the mail list or privately.

Thanks and sorry about the disappearance. At least I feel brave enough
to click on the sparse folder now.

Chris
