Received: from mail.commetrax.com (mail.commetrax.com [141.95.18.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8682C2376
	for <linux-sparse@vger.kernel.org>; Fri, 19 Sep 2025 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.18.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269047; cv=none; b=jhHSxhtso//q6NDyjydivX5nUTkSyeuhGC3W+Iqq8hHJZxkZVaPlUbrz/MBxifsjip/MBm0EN9p6i4BUxilpPrGz+kDdTGD91uc/vvulI21+CVBHDbeu0R65eFa4tWPNjiq1RBQ2ttAoDgBZaD2nZsh3K0phevRf9RFFqbfzP+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269047; c=relaxed/simple;
	bh=v3RQWSOntUoa93sDsYL7hYHyokRIR6tnNKjG7I6ek50=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=gWwqcHaSBPLEcAaM50istZUbfugZuGsaUKlsLmN2MV4wSbA1dPqz6GDDsb31CtQDUpj0C7MWIQRSVwf/9L8L0nFlcufeXFec+I/ErHGmINsDvoCUOK8YXKssuXeIVEstMtNI4IUg930EzzzYQFDLKnlZ9dyjQyi5zsbw7ley2mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commetrax.com; spf=pass smtp.mailfrom=commetrax.com; dkim=pass (2048-bit key) header.d=commetrax.com header.i=@commetrax.com header.b=i5IF6AtB; arc=none smtp.client-ip=141.95.18.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commetrax.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=commetrax.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=commetrax.com header.i=@commetrax.com header.b="i5IF6AtB"
Received: by mail.commetrax.com (Postfix, from userid 1002)
	id 36D3A243C9; Fri, 19 Sep 2025 09:55:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commetrax.com;
	s=mail; t=1758268558;
	bh=v3RQWSOntUoa93sDsYL7hYHyokRIR6tnNKjG7I6ek50=;
	h=Date:From:To:Subject:From;
	b=i5IF6AtB6PK1eN95bPeASGUUKFN2q23aUJTus4oUMgYEiB0We/gQIrBXrs4HshPR1
	 uruM9GhmUpf2bVOYx5dmj/10sY7qrfUzYZcy1AL7Ivob3Bx1UquCndHF1NJqi6ThB1
	 IK1zf/m/lUY9JH8YvZMoJnmn8d4Y5/9UqP4XE/Kne8B6uM9LIhLOcCPNN4aktigGMf
	 JGhiDCtpyjninlIvGovigi1ITCEWfwVYF+fSeuO7ZGRQyqAUdWMaVxDzSzsxjMjkdS
	 7jnJb1nO0Z3MRS61vIc1GwA9Mu1fwXvgXVDlTfec4O62SVqZyyEYgRSWW2eYPm+6+K
	 c+4hz9rKZiifw==
Received: by mail.commetrax.com for <linux-sparse@vger.kernel.org>; Fri, 19 Sep 2025 07:55:29 GMT
Message-ID: <20250919084501-0.1.bs.132a7.0.pin2dwairh@commetrax.com>
Date: Fri, 19 Sep 2025 07:55:29 GMT
From: "Luke Walsh" <luke.walsh@commetrax.com>
To: <linux-sparse@vger.kernel.org>
Subject: Outsourced welding teams
X-Mailer: mail.commetrax.com
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I would like to reach out with a proposal to support you in welding and a=
ssembly processes.

According to CEDEFOP forecasts, the shortage of welders in Europe will co=
ntinue to grow until 2030. This means higher risks of delays and increasi=
ng costs for in-house staff.

That is why more and more companies are choosing the =E2=80=9Cone-stop se=
rvice=E2=80=9D model: one partner, a ready team, and full responsibility =
for a specific part of the project. This is exactly what we offer =E2=80=93=
 from outsourcing to complete coordination of welding and assembly work.

Do you currently have projects in your schedule where such support could =
make a difference?


Best regards
Luke Walsh
