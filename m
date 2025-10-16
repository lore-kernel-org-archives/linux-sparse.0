Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458873054F6
	for <linux-sparse@vger.kernel.org>; Thu, 16 Oct 2025 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603371; cv=none; b=GRmjs8/daEq0jWfl0z/gwjEvHUCfA9QBmrXCb8zIc5j7MpT+H5AlPW/VPdGWpmHstMg++igIgj9i0NnMXJ13HcXj22bzSH3idfMTzbiv/AMZz6cNUelPtYokyDccQ6A3Sl0fGDg5ZrPzWluJbCFo/ofa7Eb49QKR8FsReVe+q6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603371; c=relaxed/simple;
	bh=9JOoUMFhgNnGPedn7kv5aFcOGzX7s5ZjeQMGkOhttnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWuHWVA5cOVk/iPAgx0CTw+QHvjXN1EbARV5HEQfhCE0ZozW6sXYJwgfp7NSQnxgL/oJyyupgTPVGM8wjzjQ4EM7uvxZ+BacmAY348c+C6ygQkYIy8U/GTgqRiaQdFcFhYg4Ruezr78b9yOQ/rZza6C9lwdsm2+SaOhiWZP9KqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ld5TFyr0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ld5TFyr0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-471075c0a18so4803065e9.1
        for <linux-sparse@vger.kernel.org>; Thu, 16 Oct 2025 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760603367; x=1761208167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8kMfev7DDm4VOEq/jumgd6CmRXsR+Xm8T/KYoNhUiZQ=;
        b=Ld5TFyr0ByvrTPQIOgyw7dV+NvVt6INdhT961Alz43r50uxp1bC3wIYhXAE27fSJMq
         JgW5P83wOjB+ZbGiyhQWepM8wQd09k19rYmhFFxuvLsJTAeq+DK9PFZiMfLTD0e0sEp0
         P9T049fF7vFtohS9phvC/wNvb8FUtYZez8uoB7/6+RdSzxxMAsIrme7w+4JmcLtzwpth
         KgIZXmmO/aNuwRVTP9jFzxCkvUS0kbYYZsTHhKAcHmf+Du8ndv/cvP0LXQFYGPU9L75L
         5psQzIEZgQsfEHbvHv0tRJiNI+onrjrQ5vLaBdbSmgVHKHps9ZuQbYLjdQ+K072JNMuL
         nbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760603367; x=1761208167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kMfev7DDm4VOEq/jumgd6CmRXsR+Xm8T/KYoNhUiZQ=;
        b=jX4rZRfqClc0Nfl9j6eFSpD4Kc48cXOuV+X0dwJGnhd9N3H2lejvdvfRvdJl3Edkom
         fjZqsBHBgnxWBgooipt2LlkVSiF6BlYh6slHQZ6LHTntc409kDmxpKTXWgIcBe0NS4LO
         NvgnQkb5zLhrXZ6a92m9rVn+s+P6Y6T7fZb2FgNLNGRc2s3E/caH8WxKDKpm80LrZp76
         ibR0r99zBhAufmZSNy6f7/kbh9NxKZJsIZwLjV1JnnUFW2hLgdK33SRycla4ozZV0Tjs
         cN/Cxnf8wY3P5zeJFjLUdjq0BDj2+jj8dSUuPzu2GRg+7Ma10YSTZrFAQ6xxonue0xCQ
         wjwA==
X-Gm-Message-State: AOJu0Yy5v1+3mX+DJQdybtiNKHO+AXKPxg+8FxwFm5KDIhCrXZ2SUZHF
	QxBQmEvuWs6qNgIPvavHoDp4tqg9fraFp0qhzjZ3ZOZCCXM7kiF6bgH2/OdYmplN8zk=
X-Gm-Gg: ASbGncst+8WWhDPEjL50gsQu77cJZ9F5FfFNPWpR4gz0mD0yhmfSk+xnHnO2ij5U49u
	eraTPnsaCwB/UyDA87cTJfZq5UZg1ySQzYXJdI0jHoFjsCBrSZydSnz8j6j9QBZaJs3mRGj3B+H
	fMbkg8e6ZYWkxc8BOuJlFb8NQ+iS+UWga9OZahcVKC/t6Izb83Od5X6qHo0FV6P4AFUPZ7RxGd2
	5OLQraDBjuExxVrO2pUeVt+dgQQY86Tv6LODAh5S5rlm77nKRHdN4DUNMfD1PgPfPuDtpnXZD/I
	USg0rlhd5HJvewCfhLgnJzFAnoO0+RktwcMdPOV+CccRlm3z3SOWyEeKZL4QZDSnmS5bsi+hkns
	9tRCJsF07HAtUYdug7mZZU9mau4zOz/G4D1R/ZSUe58Y2Se8ZgZloHAWVJzLUSr+i4ZfPlV3Dzv
	yB6xqFahP6Cg==
X-Google-Smtp-Source: AGHT+IGZjsa7dfp8e3lVecjUuNkxllCZC43VnIqLC6XRhXfFkJy9Blr/ePCheVa30hu5566PwlB3cw==
X-Received: by 2002:a05:600c:1990:b0:46e:1b89:77f1 with SMTP id 5b1f17b1804b1-46fa9aa1c74mr212566865e9.9.1760603367525;
        Thu, 16 Oct 2025 01:29:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4711441f6afsm12366285e9.1.2025.10.16.01.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 01:29:27 -0700 (PDT)
Date: Thu, 16 Oct 2025 11:29:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>,
	Kees Cook <kees@kernel.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH] builtin: implement __builtin_strlen() for constants
Message-ID: <aPCs46Sno0a4dsyK@stanley.mountain>
References: <aO-cvXncl7dbnP_J@stanley.mountain>
 <CAHk-=wgKcf_dP0_7yTqL+JKc03mhFgqFHkN7jXLUrOy=WjWZUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgKcf_dP0_7yTqL+JKc03mhFgqFHkN7jXLUrOy=WjWZUA@mail.gmail.com>

On Wed, Oct 15, 2025 at 08:13:51AM -0700, Linus Torvalds wrote:
> So you should add a
> 
>     #include <string.h>
> 
> at the top, and do something like
> 
> -       expr->value = arg->string->length - 1;
> +       expr->value = strlen(arg->string->data);
> 
> in there instead, because constant strings can have embedded NUL characters.
> 
>            Linus

Ah.  Thanks.

regards,
dan carpenter
