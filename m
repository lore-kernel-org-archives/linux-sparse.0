Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0E612AAE4
	for <linux-sparse@vger.kernel.org>; Wed, 21 Feb 2024 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.233.160.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559294; cv=none; b=qof44QcIndsGQZeKMGH7Sjv2j8DS/g8xSjsTKuDyTdteLSFe/opBWjpe5vFZEjYtDIyrcORaPQM3m9IqYgmiIjSlyM4sWqk9cNndlmnvuZ+nyuMs0kdWKYFdF54x1U+waSrobwvVm94K354arUaRHPVwm3yyOslKK+wFkLPQ6ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559294; c=relaxed/simple;
	bh=XJiRED+HKmX2yXfxqAaExlx9xlNYw4B3e/vy8FkaMB0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=HGsA5SXehtcgzpA05n2m69+8cqwsSt07+L8U70Thw3z/7X+CxNcG/X5JT4fJyP35MphQ44lVwSEe7fH7drMPFEkiz/e+ki3nik/awIQ1BvT1OPD/C/gOsBoyI/BHJsCSkPMptnyJTq8ggniDd0JEobNxr83gcM+JkY8w+SN7aSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=knosof.co.uk; spf=pass smtp.mailfrom=knosof.co.uk; arc=none smtp.client-ip=85.233.160.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=knosof.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knosof.co.uk
Received: from [137.220.76.66] (helo=[192.168.1.186])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1rctjs-00000000BCl-3t34
	for linux-sparse@vger.kernel.org;
	Wed, 21 Feb 2024 21:02:49 +0000
Message-ID: <f074cdaa-d702-8c78-21ee-942cf346282d@knosof.co.uk>
Date: Wed, 21 Feb 2024 21:02:48 +0000
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Linux-Sparse <linux-sparse@vger.kernel.org>
From: Derek M Jones <derek@knosof.co.uk>
Subject: Rust style ownership semantics for C
Organization: Knowledge Software, Ltd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

All,

Cake is a C tool that implements Rust style ownership semantics.
http://thradams.com/cake/ownership.html

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com
