Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F021D12F
	for <linux-sparse@vger.kernel.org>; Mon, 18 Dec 2023 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqDUizqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3A1C433C8;
	Mon, 18 Dec 2023 13:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702907499;
	bh=zni6E0geUBEa+VcgoWM3lbO9/Qz0g9vGcSa1egY7ThU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqDUizqLTkKUQaHA4gkYPAqOtUJGLN2pAN++G2VEwEbU3QzIkfkrDNj2b5CdzsbPk
	 nlLPMDIry/lRDm4oDci1BOM/PaZCCfNb91gYQObBjniSuW9dRcdEyHzNx1TMYebhe5
	 BLdseKCLNdbTVF1HTSGXgBBNU2vPY2CYcQDtaCAxJ+XzzZXPF3O+jSMBP1mYVpe0J+
	 vkDgdYXoKditZRhOuZKP40NqMwUZEfgX/M42nRDqA0YuyFdQuU8l2lNhhZZLEBQ7lL
	 kZMZ2lBbeQtN+Yr+6JMP5KTyfsBgFOzVcH/Wx8cUtt4bvPid6rJ938tQGjUxUToklO
	 yw7MYMiERxqrw==
Date: Mon, 18 Dec 2023 14:51:32 +0100
From: Luc Van Oostenryck <lucvoo@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2] parse: handle __cleanup__ attribute
Message-ID: <troz4beymvsw2m4y4ocghwiidohi4nbj45ry2tfmbekanu2ray@ooravawiynxr>
References: <8d596a06-9f25-4d9f-8282-deb2d03a6b0a@moroto.mountain>
 <i4s2gnr6rlq3yhmfiy7lkbsahnaioilksvmx3eocdjfh2434zo@zhxhwwgqpxt2>
 <44e22df1-734e-49c5-b20b-4f4cdbce24a6@suswa.mountain>
 <75ee8bd3-aa80-46dc-9f0c-874a8f4e9d48@suswa.mountain>
 <k6ztyjq24ik24qtsu3aqpipodzgq37i2ko42ag7wzn4t2ryrzf@i4gbxu7kvslt>
 <c3884893-44fe-4622-8e8e-576a0bdff19f@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3884893-44fe-4622-8e8e-576a0bdff19f@suswa.mountain>

On Thu, Dec 14, 2023 at 04:20:20PM +0300, Dan Carpenter wrote:
> Yep.  Perfect.  Thanks so much!

Pushed now.
-- Luc 
