Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198C1779A5;
	Thu,  3 Oct 2024 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971891; cv=none; b=jqp4BWIS5W7PG65EJlJFvq0aVlzPcJOVa/cOcGM2xmYv9OS2w8oWkzVUmgLzYPg8kgzV6cHsSYnN/pNL4UOWbCYg+gbTkJ4C1zmOwYwBoUVKK30GOmDprH+JXCUn+XLYGzLkV/KVfZ09ahBztmak1teCKo7E5v+A9JIPNS078C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971891; c=relaxed/simple;
	bh=RBTkyoqQBQWgJfvXHK3j1LZTf2HaqtLVUqrz+n1nGS8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VH6L2oGroPrBnI74eLoVWWTtzxKcmECfn0R3Yfu4eF3ULjJIWhZqaAxDbSAlJLg9/1WkMf48kMUCMiqdbDiiqqv2J3H2hWhw4s/FRpClD+DXAAz71li7urBY1yan9RrZnCYsyvdupfZHXr/yIhoobwT9d/BoKZEskMMXKZaBt20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFjdn9qr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFjdn9qr"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so166751966b.2;
        Thu, 03 Oct 2024 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727971888; x=1728576688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q32JbGi18+OdbRw4TK5uJ1wmgJog0ZexuMhgdGd1U7A=;
        b=LFjdn9qr90yo7XJZA/xw5CDDwAa8LMLE8ITR6QtIv7B3xAfvJLT7+Y4p/4z0xr7933
         vwetGXPSTa+cIS+oIeKeVIaKDRcIPxqgiIStue1t7RajGymAClqlnr16Wm8huZefvW3O
         pry7Z7qXSwu4iJKIskrTkftDxT0DaoGOWA4JaUL4cS6zljCvg5rX/BxZisNUe63wIOia
         W6xEqrZwKkxaBwoE6OXWd57yu/cUvsrecVlsgA7AnDiAZnyHTuJ3ciBKDkuFRA5kvdwK
         CbbhEIUytGYDNaWmhwk/7j4Yo8j9K2koW71onqlsvRQR2BuZ81W624uxecRjOMyP7wq/
         WqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971888; x=1728576688;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q32JbGi18+OdbRw4TK5uJ1wmgJog0ZexuMhgdGd1U7A=;
        b=fRkznvk5j8zDF/eOvuWNvlFI/ktoh99PjHKQD+ARaD0MhUHrqiTKWVWHubs8DVd9ri
         SClgeklvhLlCIJlMh+mo/gv5e5ZTVhQatHSWmMuGIqKKlYbTFBE9rPwPpZl4MiOUwELc
         sdFY2e28du31Ro5ykz5wFgSMxwm8XqLRZapFg/cDOtGyMc8jkWNgsrB0uT4EXrf/7isJ
         FQJZDPrtE/phGucTZ5zZNASCpe3DBQlx7OOTf3pgzyGnlYRGSwSlTw6NmHTpXJRQO7pF
         dCiwPVX4/TzIvX2MZEW3yJY9WulUTXv4C+jX4fxqzSEi2c2nmsOIR/RLSRAAyzxr7i2h
         cr1w==
X-Forwarded-Encrypted: i=1; AJvYcCUb8lcSeMJjyhl+fL4r9nt/kz07N2yA7slGtsE1KSL7MJKpb65wJuDNRMlY3wckFTP8+o2lhCCt@vger.kernel.org, AJvYcCX+VRBrXJpt0aL0W9ZbhFVS10KZY0FISiH1rfJ0i83bNLbL/OoWqwyC1ynxxszzu4e6FEcAOfnIaK2N7A2m@vger.kernel.org, AJvYcCXBJihinsgpsDI6ZObx5Fcevp5O5OskiuvusL2JhaXvDmYvvqfEnJPkcNqrULSgj83jk8Whu75pcarQB28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4TRzkfbFr5eHcuQibnvZ4d2p8SBGvWI8s5JNEvivAgn8iK/bH
	7n2gdUvE3PD3Rf+xk48DKVw773pA745bH7iF+HUJ/yBvyeZviSd/iWDe5g==
X-Google-Smtp-Source: AGHT+IGVUxJ3Rjm+l2YhrSaIEYLUyEHl58QHM5FDOIe0jd4iDF22k/ljd6Y1nEVy8WHcPBHoFt0avQ==
X-Received: by 2002:a17:906:4fcc:b0:a7a:af5d:f312 with SMTP id a640c23a62f3a-a98f837d235mr701438966b.46.1727971888087;
        Thu, 03 Oct 2024 09:11:28 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9910472f96sm104790066b.146.2024.10.03.09.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 09:11:27 -0700 (PDT)
Subject: Re: [PATCH net] net: add inline annotation to fix the build warning
To: Moon Yeounsu <yyyynoom@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 linux@weissschuh.net, j.granados@samsung.com, judyhsiao@chromium.org,
 James.Z.Li@dell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>, linux-sparse@vger.kernel.org
References: <20241001193352.151102-1-yyyynoom@gmail.com>
 <CAAjsZQx1NFdx8HyBmDqDxQbUvcxbaag5y-ft+feWLgQeb1Qfdw@mail.gmail.com>
 <CANn89i+aHZWGqWjCQXacRV4SBGXJvyEVeNcZb7LA0rCwifQH2w@mail.gmail.com>
 <CAAjsZQxEKLZd-fQdRiu68uX6Kg4opW4wsQRaLcKyfnQ+UyO+vw@mail.gmail.com>
 <CANn89i+hNfRjhvpRR+WXqD72ko4_-N+Tj3CqmJTBGyi3SpQ+Og@mail.gmail.com>
 <CAAjsZQxkH8nmHchtFFPm5VouLEaViR5HTRCCnrP0d9jSF2pGAQ@mail.gmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <e5cb1a17-72e1-529c-0f46-404dcdb3e5f3@gmail.com>
Date: Thu, 3 Oct 2024 17:11:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAjsZQxkH8nmHchtFFPm5VouLEaViR5HTRCCnrP0d9jSF2pGAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 03/10/2024 16:33, Moon Yeounsu wrote:
> On 03/10/2024 15:19, Eric Dumazet wrote:
>> It also does not know about conditional locking, it is quite useless.
> So... What do you think about who wants to send the patch to silence
> the Sparse's warning message, nevertheless?

Fwiw, my experience is that if I can't explain the locking to sparse
 that's usually a sign that the code is too complex and needs to be
 rewritten.
In general I'm in favour of patches to fix sparse warnings.  In this
 case it looks like what's needed is __cond_acquires, but the patch
 to implement that in sparse[1] doesn't seem to have gotten anywhere
 near Luc's tree.  (Yet it's present and occasionally used in the
 kernel...)  CCing the sparse ML to find out why.

-ed

[1]: https://lore.kernel.org/all/CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com/#t
