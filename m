Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17134BA52
	for <linux-sparse@vger.kernel.org>; Mon, 22 Sep 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546035; cv=none; b=CI2qAikea8ksME8qY1R6CqrT/WprEtYHNaIjcnNm3Ziy4tq9N+nI4CPKFd6po13vdHaWpQJ1mIJhf7h4Bq/FkLtzYsfj//Ba94ViiyRTGjz9E9KyPMsSDHYwc3WE4dPETvxUWUvpAeCCUnFJXLai95eW4hbZGIfxdoMyXKVHGFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546035; c=relaxed/simple;
	bh=+t164Erj3TW7OlCHUYY2OjCpagXPscW9MxivtccFvpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtKPjUVohRR7PYjX6rlpJnoEmZxtiXG0z0BZ2kde9IoJz9q0NDp3t71/OYo/MbLJ5V0B/FW2/9J/rtjjQi27n6aGiBL9Xj3rKol5j57JmXzjvcM4LDbtC2gk8iH7nx5KMDRNh1XSJFmQztDgLe5vC6HNQF0qRiHN523CpA7/mY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECb0HpIA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECb0HpIA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758DBC4CEF0;
	Mon, 22 Sep 2025 13:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758546035;
	bh=+t164Erj3TW7OlCHUYY2OjCpagXPscW9MxivtccFvpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ECb0HpIAHJpgqKzOpME4PlBRBaoYyl5e1Rt+8r54crlHJ1IQVBOTUs7nI+jPOOAkG
	 /7RtClsffCZcU+50IQpOttpr2E7KxVbjS/powmWqsvcUKyVfv3oVklh2mpxrEU/IXq
	 GFKhTP1UfIqHTD3FdQJR7PPjkC3Ix5wh8XFYEY3IHzViRdOb4wWhtJuqcu9f0ZQnJ+
	 DbaGHKvu+S8VH99mqTTmS12K3iD9GJBXt8N2M/x9PpLTPBlBX2okudYMKu2fp4V+Bh
	 9tiGFCeXdshocEUX6L8JHphq3vccmc+DXH3u6VSGf9jhDu+860jPrrzGeyy0BiXp5x
	 RsbM4ZNdlLuQA==
Message-ID: <9d263950-f44c-42eb-b22c-a5849399f036@kernel.org>
Date: Mon, 22 Sep 2025 22:00:32 +0900
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Warn about "unsigned value that used to be signed against
 zero"
To: Chris Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20250921061337.3047616-1-mailhol@kernel.org>
 <CACePvbXRkT7wtc2nUttMVXWw7C5r_zLewj1fWkW=9pjAxagLkg@mail.gmail.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <CACePvbXRkT7wtc2nUttMVXWw7C5r_zLewj1fWkW=9pjAxagLkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/09/2025 at 21:02, Chris Li wrote:

(...)

> Can you please add a few validation checks for  the positive and
> negative case? You  can add it under the validation directory. With
> validation I can quickly catch the behavior change in the future.

No problem!

Would something like that be OK?

diff --git a/validation/used-to-be-signed.c b/validation/used-to-be-signed.c
new file mode 100644
index 00000000..75c0ca38
--- /dev/null
+++ b/validation/used-to-be-signed.c
@@ -0,0 +1,25 @@
+void error(void);
+int check(void);
+
+static void foo(unsigned int val)
+{
+	unsigned int ret;
+
+	/* Positive test case */
+	ret = check();
+	if (ret < 0)
+		error();
+
+	/* Negative test case */
+	if (val < 0 || val > 42)
+		error();
+}
+
+/*
+ * check-name: used-to-be-signed
+ *
+ * check-error-start
+used-to-be-signed.c:10:19: warning: unsigned value that used to be signed
checked against zero?
+used-to-be-signed.c:9:20: signed value source
+ * check-error-end
+ */

Output:

  $ ./test-suite used-to-be-signed.c
    TEST    used-to-be-signed (used-to-be-signed.c)
  OK: out of 1 tests, 1 passed, 0 failed


Also, do you want the test in a separate patch or should I squash with previous
patch?


Yours sincerely,
Vincent Mailhol
