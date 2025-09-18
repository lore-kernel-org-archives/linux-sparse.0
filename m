Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403672628
	for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.233.160.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223409; cv=none; b=ZccA5VK/KJImDmwkCllDk2FDZObjFSQ/eXELI6rFsnJckeGfkhrX42ByF8Dhu+VgJuRT11yG0pYn5pzRUYtq1kJtViVM1EVRGr+gdhF2D6UnLt+bQqUM4280PqTOy7sEpaabyUedLbQiuyQ5ZZsjZlZ5VZuF7VfqWcxt8OsjrpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223409; c=relaxed/simple;
	bh=6th4aGwtl5fIcPR8gNyofFPrStAE0Y7kVrfrz5PHN5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CYxz/aiqeQrnLCezeOOwwc9MOmGEzyL+CYHV/8N7nwBlXpH75xWZWuuGoD92wE52vKndPIRvp32O8GHgOfARJu3VJN7CaArpS1JU40RX/+bIukWC1AGjSugF7L13KNhAxa7aHBSnTYnyHxyUcZtx5P4tawFf4RQYYKXlkDNqPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=knosof.co.uk; spf=pass smtp.mailfrom=knosof.co.uk; arc=none smtp.client-ip=85.233.160.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=knosof.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knosof.co.uk
Received: from [188.214.11.61] (helo=[192.168.50.78])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1uzH0u-00000000BRo-9oX6
	for linux-sparse@vger.kernel.org;
	Thu, 18 Sep 2025 16:57:40 +0100
Message-ID: <6a61a6f7-7455-481a-90fd-4b41f376ec7f@knosof.co.uk>
Date: Thu, 18 Sep 2025 16:57:40 +0100
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sparse maintainership
To: linux-sparse@vger.kernel.org
References: <CACePvbXDO1ZybDu3RaFhED9D-9gC6LTMpWrxoh5xD+ZO5SLdzA@mail.gmail.com>
Content-Language: en-US
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <CACePvbXDO1ZybDu3RaFhED9D-9gC6LTMpWrxoh5xD+ZO5SLdzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Chris,

> If not, does anyone mind if I slowly resume some maintainer duty at a
> very very slow pace?

Welcome back from an early days commenter who is now a long time lurker.

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com

