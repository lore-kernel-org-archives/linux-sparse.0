Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB72325701
	for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766148254; cv=none; b=PyNN+FA1+GjBZRMxzDQU/Gm6GWQqE+/LXH9RZtIFsBh6xwfuJNmQKSjNgCqKqN85r3f1s1/ANf8Iri/tQ96uYWqYOvFRM5vz5TRZbiApjXoV0i5Iv9g9M99TXkZ66WodlH2l0AgiI8N1gIi30yRbdqhPDTWy1K/JMWQM20hwMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766148254; c=relaxed/simple;
	bh=GPZuwoozuAGjv9w0ymSfsuTZftLR4oDKUlvOpzKbWMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebQggPJeB7y/+Z0Gfu/5RTl5ha5/v3ytoqr702p6UuM1vQAlUvrKeE8Kh2iO1kWwoQUVRiDSZw+2rHqOh1ex3bs6dDhxN0VR+PeqcFmWm6bx4p4ucRHobpZrPQlkLVrssJZ5yjKQVfzAGrKVQ93Dj6wLwVb3638IdkzHlt+SeBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TTmHsRZX; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TTmHsRZX"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-42fed090e5fso869135f8f.1
        for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 04:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766148250; x=1766753050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zqJodAAexbDXbzG4ziuX+RHvdrWJghAK+tfZzJOfXvE=;
        b=TTmHsRZXPGUgJxj8hgN+4+IOD7HK1pQRi72gZFBcbGIHIoaWt+b0M8ztEVs4HWnaK6
         sKoNjjXyAiq2fPwkQCrSOLHfoKFEMcygsKeIAxoQjocci+rCEFHFHSU2JBb012wDbUoB
         Kc/0FYKlHXoq7dPmhIa5n0J7mZ4GQlmUwdwGZ+e31oHKv4fxSPP/fHHELL8HUARZ108o
         LbsBX+hFnWvXiQPnG2UdTarWSg5dZqe61ULWjZQMzaJl04aDa/+ucQXprbJhcCpWExLA
         uAFU7HnQ5X7yxPFg33tSafjUKXPh0TEelj7IJDsvASVjgumur08JiIuAMUQBhLX7tW5e
         mFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766148250; x=1766753050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqJodAAexbDXbzG4ziuX+RHvdrWJghAK+tfZzJOfXvE=;
        b=SMhllJlMx2ikeb1d1JPWCYg/P0d5zsdIaHIP6nGse0GuGJHOLJrOPjegwMrizTDzSF
         w6tLLwJ5NLGz3rlDExz7E+NRBOilnz4iIoiKltcS00v8kTOE3mYnjj2JveipExQ+5Zxo
         BBHh4w1kn7xRbflnpgNqA5Ne24tv3c4vxdAuOnvABcl6cAtWnAgLmL++qK9HaEbjVBMO
         +oqm+8peAvEdR1Pnz9Gw1u/CwaeUXvMZpF0jZ5hDbaM9q3YqsUb+IWgkw7jQZsSZdN/J
         Z5KzSp1oj1GpF1E7gPQ1+vVcEoMkiF16Wex9Nzz8rry1QtsU16Bu5B0mvcYDiGx9k/7g
         jr5g==
X-Forwarded-Encrypted: i=1; AJvYcCU1JLqKDGh/QmeCrreEfdNnMKWA5AI33R0Cy6+JXmy/5cVJI5YXaHE6ucdnfVD7Ytt3pM0T/eyO8BuBNnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6t0GXh5qo6oLv8+eB0YNq69RbycHM4KUD8BAfB3IJqfBD8dgf
	QBBUYStZNnfmuhaPys8aNu5p1C9D65Z5A1Vr5vx5YKP5nj0uP7MfHV/s+vTh0iXADK8=
X-Gm-Gg: AY/fxX4xHllUMCOWvtW0qsOQv0KKo0rzTrYvdwxYulm7vI8DwMxKS30EGkoGOhgjXTO
	Tu43XDEG2ara94eWaKbDnBa4cll0msnq8Z2E3DcFDwHARbMr/WlZvHe9ulR7W/1rR//FL3+0vcl
	/SXOO9nRGht2vWh+D69yGbsrEfvHMx+otct4nJLsfn97exLcWZH3Bo0TrMbjIRKdEYxUpilOMDM
	8DrmobnfK/Kmd96fbFH1ywqz9QhgilEeZIdGD93fHvMGcyJ1INHMvNeyzn/SPgf3ft76jUHYOGO
	8ks3t9OwACjxg3j9EEtzH2s+e+aE1ymAL0uesvMY6raTEUr+5Rr2aWZYgoPT7gf7/oXS4xDclDV
	x/rO9vRst6xdRp5wM/U8La2tkWo3pR5QFyIH7xqLi0p47EazaO/fzUn0riaQ71ABElglBk/2Muz
	iUVwdxYiemfK0jTBi3
X-Google-Smtp-Source: AGHT+IGG+wVBFX9Lbyf5X5m7oA1PcjdwjHnK15w70nggTuAbT2I1hgnSsU2lA7AlrqPTLo9GEXlYag==
X-Received: by 2002:a05:6000:220e:b0:430:fc63:8c1 with SMTP id ffacd0b85a97d-4324e4c9e4emr2999115f8f.18.1766148250366;
        Fri, 19 Dec 2025 04:44:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea225fcsm4983162f8f.16.2025.12.19.04.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 04:44:09 -0800 (PST)
Date: Fri, 19 Dec 2025 15:44:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Malcolm Priestley <tvboxspy@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>, Chris Li <sparse@chrisli.org>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2 3/3] module: Add compile-time check for embedded NUL
 characters
Message-ID: <aUVIlvOSvobrdrKV@stanley.mountain>
References: <20251010030348.it.784-kees@kernel.org>
 <20251010030610.3032147-3-kees@kernel.org>
 <47a2f0c7-c25f-4734-840b-fdefc2f3c4a9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a2f0c7-c25f-4734-840b-fdefc2f3c4a9@kernel.org>

On Fri, Dec 19, 2025 at 01:29:21PM +0100, Matthieu Baerts wrote:
> net/mptcp/crypto_test.c:72:1: error: bad integer constant expression
> net/mptcp/crypto_test.c:72:1: error: static assertion failed: "MODULE_INFO(license, ...) contains embedded NUL byte"
> net/mptcp/crypto_test.c:73:1: error: bad integer constant expression
> net/mptcp/crypto_test.c:73:1: error: static assertion failed: "MODULE_INFO(description, ...) contains embedded NUL byte"

There was a fix for that posted.  Let me ping them to see if anyone is
planning to send an actual patch.

https://lore.kernel.org/all/20251211175101.GA3405942@google.com/

regards
dan carpenter

