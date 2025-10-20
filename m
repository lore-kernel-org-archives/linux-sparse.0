Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE123507E
	for <linux-sparse@vger.kernel.org>; Mon, 20 Oct 2025 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954528; cv=none; b=Fl68zWOdOxKGq7wz1UnNn0ppYgPke5iUuv2J4zk38zT/1CKwQxSrpRrukuYETeLmY9bumIVKifTg24eUA9S3Tg0eX2G+skBmSr3JyE5CV43qD2ibW5x7ttRsX5QRhjBocJ3g/OahNyHYL9liwjVeZUN2twoWKX0bHjYW7PLuqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954528; c=relaxed/simple;
	bh=X+kNrJctuef8vyyUecR1dDgxs6hy+G9hYAC6RqUB+Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTKTLRZcxGvpdctIH9zaBi28BLinDRz0i6aI9q855yiV6IoEq9sYKaJSeH8KTiZwQL2k0rpt5kqLg/zwdYjnqgF7pSxf9nJdYOsexb7nARXfA/Vu6m29AELx587xUOUtc5Y4ijnEDJHDaG6oqbk7/qw353JdKIasrCMLoLb1a68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=KkKTGDkx; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="KkKTGDkx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=p4ItBLlW2Dy2Mw6MXFmb/i+CmZw0S0rf+mGFNBraT9s=; b=KkKTGDkxhxns5kIN
	YTM2QfbkJLo9R4pPbIaOsTQ4UCf6DKi/rb/M/pdzYL4sK9pLLdZGEl6Cl0Q5C1efE5QAQbrwBWe2o
	y0W0WkT4b7pxptquS7dHrVmN/NKz/hS79orv3qDiI1Be6sUUk1Pa31y6irGww5rLZb6n5WbNjkDbv
	FnDiobwc2+7cRkoYcIuAWbf+L6Vu82NWziLmpFWu2MCK4Ird3pME2TX+eRPzHdo2MuuUZol0mxM9k
	2cnHy23TaYzkrl97R2v9yX34wBAhrlWpYHJ10kT0rULY0yoQb+P0lSlVqWrvQb8Xicv64Sr+PjQFX
	fBQ7UDWnY9ci4/fa7A==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vAmiC-00Gv4g-FR; Mon, 20 Oct 2025 11:01:56 +0100
Message-ID: <1b0f2789-e7da-40ce-a852-67abda29f787@codethink.co.uk>
Date: Mon, 20 Oct 2025 11:01:55 +0100
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Add printf/scanf -Wformat checking
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Chris Li <sparse@chrisli.org>
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
> 
> The DKIM message headers look like this:
> 
>    DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
> d=codethink.co.uk; s=imap4-20230908;
> 
> so far, all good. You have DKIM, it uses relaxed/relaxed, all great.
> But then it continues with the list of headers that are hashed:
> 
>    h=Sender:Content-Transfer-Encoding:
> MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:
> 
> All still good so far, and those are the right headers. But they are
> pretty much the *only* right headers, because the list of headers then
> goes on with
> 
>       Content-Type:
> Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
> Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
> List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
> 
> and that's just bogus.
> 
> Having email list headers in the DKIM header hashing means that any
> well-behaved mailing list that adds its own subscription headers will
> now result in a different hash, and DKIM will fail, and anybody who
> reads the list with a sane MUA will not see the emails you sent.
> 
> So by all means keep the "In-Reply-To" and "References" headers in the
> DKIM list, but get rid of all the "List-Help" etc headers, because
> they are actively wrong and bad.
> 
> I've seen this before, and I have been told that there's some Debian
> DKIM help page for DKIM that lists those headers. I don't know the
> details, but that help page is really actively wrong and should be
> fixed.
> 
> Typically, you should really only list the headers you really care
> about: things that *matter*. Things that make it clear that it was
> from you, and what the subject and thread was.
> 
> Other headers shouldn't be hashed, exactly because there are valid
> reasons why those headers may then be added by intermediate mailers).
> 
> Anyway, what this results in is that when I look at the headers, I see this:
> 
>    ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
> dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass
> smtp.mailfrom=codethink.com; dkim=pass (2048-bit key)
> header.d=codethink.co.uk header.i=@codethink.co.uk header.b=x51xpGj+;
> arc=none smtp.client-ip=188.40.203.114
>    Authentication-Results: smtp.subspace.kernel.org; dmarc=pass
> (p=reject dis=none) header.from=codethink.co.uk
> 
> ie the list receiver is happy, because at the time the list gets the
> email directly from you, the DKIM hash matches, and so DMARC rules at
> that time say "all good".
> 
> But then when the list re-sends the email out to list subscribers,
> they will get something like this:
> 
>    Authentication-Results: mx.google.com;
>         dkim=fail header.i=@codethink.co.uk header.s=imap4-20230908
> header.b=x51xpGj+;
> 
> because the list expander has added headers
> 
>    List-Id: <linux-sparse.vger.kernel.org>
>    List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
>    List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
> 
> (and possibly others) so now the header hash no longer matches,
> because you've told dkim to hash those headers. They obviously weren't
> there in your original email, so now the hash that codethink computed
> is no longer matching the headers that the list sends out.
> 
> And this is a well-behaved mailing list that does what mailing lists
> *should* do, in adding those headers. It's really your DKIM that is
> actively wrong.
> 
> If you remember where you got the bad list of headers from, maybe you
> can report this problem upstream too?

So our operations people dug into this, and it looks to be the default
for Debian and possibly the upstream Debian too. From the ticket:
  >    We don't explicitly set dkim_sign_headers in our exim.conf, so 
according to the docs, this defaults to the macro _DKIM_SIGN_HEADERS
>     pulling the source code from the Debian packlage for this, _DKIM_SIGN_HEADERS is set by the macro PDKIM_DEFAULT_SIGN_HEADERS:
> 
> #define PDKIM_DEFAULT_SIGN_HEADERS "From:Sender:Reply-To:Subject:Date:"\
>                              "Message-ID:To:Cc:MIME-Version:Content-Type:"\
>                              "Content-Transfer-Encoding:Content-ID:"\
>                              "Content-Description:Resent-Date:Resent-From:"\
>                              "Resent-Sender:Resent-To:Resent-Cc:"\
>                              "Resent-Message-ID:In-Reply-To:References:"\
>                              "List-Id:List-Help:List-Unsubscribe:"\
>                              "List-Subscribe:List-Post:List-Owner:List-Archive"
> 
> looking upstream @ https://code.exim.org/exim/exim.git - ./src/src/miscmods/pdkim/pdkim.h on the master branch
> 
> #define PDKIM_DEFAULT_SIGN_HEADERS "From:Sender:Reply-To:Subject:Date:"\
>                              "Message-ID:To:Cc:MIME-Version:Content-Type:"\
>                              "Content-Transfer-Encoding:Content-ID:"\
>                              "Content-Description:Resent-Date:Resent-From:"\
>                              "Resent-Sender:Resent-To:Resent-Cc:"\
>                              "Resent-Message-ID:In-Reply-To:References:"\
>                              "List-Id:List-Help:List-Unsubscribe:"\
>                              "List-Subscribe:List-Post:List-Owner:List-Archive"
> 
> So yeah, this is just the default exim config...

I think this is now fixed, will re-send later.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
