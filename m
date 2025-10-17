Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068AF257820
	for <linux-sparse@vger.kernel.org>; Fri, 17 Oct 2025 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687255; cv=none; b=isrhfAiMJPOlXK5j1t/uczfKRyvUEvMulK/Sq0Df6fXxWrOzqv88q2SoAqTLK5NtpipZ+/ijjIUCiV7j7gyFl7i1/5JX1hGT1uiamESSt14iyTSIC4Pfv4Jw2r5xOnml5Uir/ZgH/qYa9eEonpofB5OSEG9eIDcW5ymq8mjgCPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687255; c=relaxed/simple;
	bh=MdsK12Bpm0MNf1S3cKHLgMtdGtAAqNPf7MPrLKqDazU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZZNCAtPgFQFHK1ON8mQwWA/Q+7DiPdEF3iItnnai8KdzovTdzmIMxw3u7IASm0ohzNDDI4TUErE4pBmVDWv6W6n3zv8sonkMSazqlZLafOsi86TdLSsDgI4MlXuQxvkxCTljYGX9Kd2my9uI1wZ3PwVUAo3yWWdplkxwHhDQvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=bwJadxvS; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="bwJadxvS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pEuYZF+sK+YurcbYiqs37iGT95YBNL4I8i7agak/+r8=; b=bwJadxvSL+lTY1TiTIC1+gKxmw
	pskJTc0uM05yFU99br0cVRKn87xXB2LZRgJjm9exhKfC41CAKgj8jL6tKTk0UWnDacSVeCDBqKjQO
	HfBJi9iJWv/TtHIgQ2cNNzLwmc3z2Z7f5dvVqBkVLWZKywKn3e2UE01AecNFG0uNkkZ1sfrI2YfmK
	5jh1SiYM72M+cyjUpVKUo03HZMVI03BKKxSceK/2wnAybI05EDC4as73bysl9YSzipT8MdnMexfgB
	x+FCNe7MWJOtRvuzoOnqhWD63YKyTBN8UupjOw8AqTBDn1X7nxu6qeIkW8JZHGKqRa3MspZT0ZiW9
	zIcNcYDQ==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1v9fBR-00FGKO-NB; Fri, 17 Oct 2025 08:47:29 +0100
Message-ID: <d9765def-8b4f-4892-bb8f-13a0a7eb01ca@codethink.co.uk>
Date: Fri, 17 Oct 2025 08:47:29 +0100
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Add printf/scanf -Wformat checking
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
References: <20251016110415.630506-1-ben.dooks@codethink.co.uk>
 <CAADWXX_kGbSjXrt9ZQGLg7R_ioEnqvZ_s+asrPAPgNnQ_LbaBQ@mail.gmail.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <CAADWXX_kGbSjXrt9ZQGLg7R_ioEnqvZ_s+asrPAPgNnQ_LbaBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 16/10/2025 18:12, Linus Torvalds wrote:
> On Thu, Oct 16, 2025 at 4:04 AM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>
>> [re-send as I can't type sparse and messages didn't get to the list]
> 
> You may need to re-send again after fixing your mailer setup, because
> while it made it to the list, I suspect a lot of people didn't
> actually get it, because it fails DKIM checks and that then tends to
> mean that it gets marked as spam.
> 
> At least it did for me - but I check my spam folder daily, so I noticed.
> 
> The reason it fails DKIM is that your codethink DKIM setup is scrogged.

Thanks, passed this on to our IT support.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
