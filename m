Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B339C62F
	for <linux-sparse@vger.kernel.org>; Tue, 24 Feb 2026 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938913; cv=none; b=KDp3Z+Skfd0NyFqdzJXD8/cC3cG3H1+km+mSCAMPC7zj1fr88GlhrDqBlHXazFus278aATJqlW8J3QCMDLbb7CJS4hZb9P4YR3d70zv5Rw2sLgnBcJ+mqtgEMPLFRlNaTVFRs/ZF066F6tWdx3zITOR6Da9iqINjFMUK7dKqbvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938913; c=relaxed/simple;
	bh=tMIEP8mnEFod7IusG5XuK8K6CIkDkb7loE0Tqc//bxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZQz91XeHfy8TE+wf3p7QWDdyN8I5FnclYeQL6EqLlmXu+ynM6JKcKfEQNiWDT4FoOkMrZy8KS9myrB5vpDwOSTXyw9tXEK4HWpmGdtqMdsa4U5ac2GsOk8Q3SrNayBgAPV4IVFYeHpEs+Yef51X1VIiOz3kUtmYdeQxua1C11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=xjub9U8X; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="xjub9U8X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=ETYgeDlvGMaeNosWxD41MZBJ7SD34udIuuBrC/WjoFA=; b=xjub9U8XQNhY4DYG
	tesedJ46R+15dhfW+LJ6FoJsZDE5sbzpZrtkd5a7705s+Qp5UMYyh/1i+ySco2NaLPhW31sZ8hvc7
	5h933ASONQcJkt3MI+X8WfzUJlV7cciUHD6pgWQUsXSz9SL3InHcSuCmRzKgcFxZYlHAy7v8n+VF8
	HDEEpYPMD5ssp6oOeUQtxNyUJ9k25GS2YtnI74s3kx7TK1DSf74RpukOgAxEFdFmC1vr6p1VAz8VX
	jS8zHBYYr5HbDtSYIy3TrDEvBUD82+boKcmrpIQFz6jhmoaEudbTZ61j7mP7F783QGvhFl/klJ0ov
	mWYQPhgXdu18p4Hgmg==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vusFm-00CuGX-PX; Tue, 24 Feb 2026 13:15:06 +0000
Message-ID: <7ccc2cf9-99f5-43ca-bfec-1417056fa982@codethink.co.uk>
Date: Tue, 24 Feb 2026 13:15:06 +0000
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparse: add support for __VA_OPT__
To: Richard Fitzgerald <rf@opensource.cirrus.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-sparse@vger.kernel.org, Chris Li <chriscli@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ricardo Ribalda <ribalda@chromium.org>, Hans Verkuil <hverkuil@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>
References: <cover.1771930766.git.dan.carpenter@linaro.org>
 <c3758782a34bf9ea174a573b50d6af4916edfea8.1771930766.git.dan.carpenter@linaro.org>
 <29424a96-4c7c-4076-99bc-903cd857f89a@codethink.co.uk>
 <aZ2R8k1MRiPwJwOC@stanley.mountain>
 <45fa5433-c95d-44ca-a072-fe31575724b3@opensource.cirrus.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <45fa5433-c95d-44ca-a072-fe31575724b3@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 24/02/2026 12:42, Richard Fitzgerald wrote:
> On 24/02/2026 11:56 am, Dan Carpenter wrote:
>> Oh, sorry, Al's branch changed that code more than I imagined.  I would
>> resend the patch, but I need to figure out this GCC warning...
>>
>>    CC      pre-process.o
>> pre-process.c: In function ‘substitute’:
>> pre-process.c:785:16: warning: function may return address of local 
>> variable [-Wreturn-local-addr]
>>    785 |         return list;
>>        |                ^~~~
>> pre-process.c:687:31: note: declared here
>>    687 |                 struct token *added, *arg;
>>        |                               ^~~~~
>>
>> Anyway, here is what I've forward ported.
>>
>> regards,
>> dan carpenter
>>
> 
> Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Tested-by: Ben Dooks <ben.dooks@codethink.co.uk>


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
