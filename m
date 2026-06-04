Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB9F21FF23
	for <linux-sparse@vger.kernel.org>; Thu,  4 Jun 2026 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.233.160.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585681; cv=none; b=aJjK8/hkVXcnwYUkTB1km38RoDLQ10jq2GNo09JcHf6xT9VeU5lHf45JE1kYxFOyZiDwV2UNG+u/dLtfF+eTY9RSNxHV/jMT/3VXW6GrLcbWpknezPxkHdR7BC7l6SjL9YgbQQ1fU7YBBjxwHDaNoMGDeFOa2Ljex66rPuaf1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585681; c=relaxed/simple;
	bh=NiBafkIPxyRhJg+Ipbpj/48a30dHxqsIgS+kfxFKCDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E+TFH4JzQ3Et52BjnLqgUAvH4UdFpT3/yWsMI8TYCYtaADC7wQrXoZJGqPgeBoEBIspT37/pErW4Jldvc4FaBvWIJ0fJNngGubAUWHwuW3QFA2wqze0/d952P1qwyEqMHaDsuYtNTO3Z6WSwmfXqWbldsgi4wUPt6OKQr8S4ubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=knosof.co.uk; spf=pass smtp.mailfrom=knosof.co.uk; arc=none smtp.client-ip=85.233.160.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=knosof.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knosof.co.uk
Received: from [188.214.11.109] (helo=[192.168.50.78])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1wV8wO-00000005NLt-2rBo
	for linux-sparse@vger.kernel.org;
	Thu, 04 Jun 2026 15:21:00 +0100
Message-ID: <fe4a18e2-c398-4a3a-b8ca-be9e7ed33ba7@knosof.co.uk>
Date: Thu, 4 Jun 2026 15:21:00 +0100
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: declarations after a case statement
To: linux-sparse@vger.kernel.org
References: <aiGAXJhYJoUuqB5j@stanley.mountain>
 <aiGCMuw3Lblnc9TA@stanley.mountain>
Content-Language: en-US
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <aiGCMuw3Lblnc9TA@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dan

> Same thing for declaration after after a label.

Sparse is correct.  The usage you describe is a syntax error.

A label may only appear on a statement, not a
declaration
https://c0x.shape-of-code.com/6.8.1.html

> $ ./smatch test.c
> test.c:5:9: error: typename in expression
> test.c:5:14: error: Expected ; at end of statement
> test.c:5:14: error: got b
> test.c:5 func() warn: statement has no effect 'char'
> 
> void func(int a)
> {
>          goto out;
> out:
>          char b;
>          b = 1;
> }

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com

