Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432182;
	b=sU5DXOqXwQWXfZHCEvhC80LztgTUC+PmDbhhhXPrKl/VULbNc+uGIWXN21U4WLvfW2ab
	 KV/WHxRUattRDI0wy34eDpfZGtjJO4GWRCidDm3UVx6WJhg1wES1Y8ypjAbK/Ff9u6Sdi
	 QRpFOyrzXZ2rrdqETM7tLGP+WF1v/U15c/+IRIQzGFejPyaXDlmIpd6sRYnuccKD9nYgu
	 kK9nENjY2mZzNALihVJjraYrn0qgR21aG4fObq4YMyOiQIgheE/J/HXoggQHmTjwEgBPA
	 ivYRL/ZiiThfLl2wxTAlqk0vAzVzPv42p6uQRCRgSlKKoJ5kPUG0mC2apibxztDXCpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=NsaE7lSeaein/wPj4BCe+acu7OTrjg4egtX2+kLIy0I=;
	b=PrpG6obstAYvihGWA/EjoSByVGjaK7cUr+dik9qIARfpKyb/lq3bi8HAnf1eJADz8mNm
	 /RZA9Xm2Wc6X2BzRmUm2g2RmVP8tpz2wIDU3cboogCBwvHNCx5lJPOGW5KAH78kefV831
	 yh83boqWu6+kQ/CfBt9uGuFabzAPhgguo8+lBJnnzUCu5M/aKAD5aokAWw4hbpoLST10l
	 ywgN3t37BDcG5UmBEwxWQe0M7XORoWTFouO8tJT+0CSlK+vLboA6lD4+s+b+L9vsy9Tqm
	 ameEUKY1Kvp7Y5V1waJxWdJ/lUjHVj6CMM2gRwLrFG1Wjn4A9VHw8XdbtQR+5ebiw0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=yYD9Tnlq;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D89B606A31A
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D89B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=yYD9Tnlq
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4j7jjW40ymzlfvpT;
	Mon, 19 Oct 2026 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792432173; x=1795024174; bh=NsaE7lSeaein/wPj4BCe+acu
	7OTrjg4egtX2+kLIy0I=; b=yYD9Tnlqe4Lu7caf01uQep6n55I39+r4KUnTa7N+
	jsL1TPXmWGYaeA5t0SFCIPqvhMk2pDjNbX4JTXLAzsjhs/ZVYittbKRquaqVifnz
	2/RS5zm+AIAjAmulIM8Dfp6nWwFJ5KonwMoPx/N66UebLw+R2GygZGQk+D6Q29x2
	2Vef/u14woLW9O0aQ102erYZ4siB8jcclNfxRr7bj5fYZ7RUszbd7N+5JFWZk9Sp
	6x2IPk6mZsb7pPu89IkXx5XwOq+wKnVUJzBaYTpLCicI15qqe1MNMgi5QJTt2JU0
	vX8l8TfxdvBjzqZ2fJpBm3IU1IahfNz25g//OCmupiqyKg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2nHcVO6If36h; Mon, 19 Oct 2026 17:49:33 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:3c23:69a5:e7:e0] (unknown [104.135.182.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jjT30t3zlfvpH;
	Mon, 19 Oct 2026 17:49:33 +0000 (UTC)
Message-ID: <eeba21a2-c0df-4c52-ade1-a27cc8e5af24@acm.org>
Date: Mon, 19 Oct 2026 10:49:32 -0700
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accept an empty attribute argument list
To: Dmitry Ilvokhin <d@ilvokhin.com>, Chris Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Dan Carpenter <error27@gmail.com>
References: <20260605113045.483498-1-d@ilvokhin.com>
 <atYKEM2RE72WZFBi@shell.ilvokhin.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <atYKEM2RE72WZFBi@shell.ilvokhin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/26 5:16 AM, Dmitry Ilvokhin wrote:
> Friendly ping on the patch.
> 
> Recently, I had some time to migrate raw __attribute__((nonnull)) usages
> to __nonnull_args() in Linux kernel, but then remembered Sparse still
> can't parse it properly.

Hi,

I'm the new sparse maintainer and plan to apply your patch soon. Please 
help with reviewing my pending sparse patches. I will publish these on
the linux-sparse mailing list later today.

Thanks,

Bart.
