<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Locale"%>

<%

double valor = 0;
double juros = 0;
double juros2= 0;
double juros3 = 0;
int meses = 0;
double poten1 = 0;
double poten2 = 0;
double parcela = 0;
double devedor = 0;
double parcela2 = 0;
NumberFormat dinheiro = NumberFormat.getCurrencyInstance(new Locale("pt", "BR"));
int i = 1;

if(request.getParameter("valor") != null) {
valor = Double.parseDouble(request.getParameter("valor"));
juros = Double.parseDouble(request.getParameter("juros"));
meses = Integer.parseInt(request.getParameter("meses"));
juros2 = juros / 100;
poten1 = Math.pow((1 + juros2), meses) * juros2;
poten2 = Math.pow((1 + juros2), meses) - 1;
parcela = valor * (poten1 / poten2);
devedor = (valor - parcela);
juros3 = valor * juros2;
parcela2 = valor - devedor;
}

%>

<html>
<head>
<title>Calculadora Price</title>

</head>
<body>

	<%@include file="WEB-INF/jspf/header.jspf"%>
	<%@include file="WEB-INF/jspf/tabela.jspf"%>
	<h4>
		Valor a financiar:
		<%=(dinheiro.format(valor))%></h4>
	<h4>
		Taxa de juros:
		<%=juros%>%
	</h4>
	<h4>
		meses:
		<%=meses%></h4>
	<br>
	<br>

	<table class="table">
		<thead class="thead-dark">
			<tr>
				<th scope="col">Período</th>
				<th scope="col">Saldo Devedor</th>
				<th scope="col">Parcela</th>
				<th scope="col">Juros</th>
				<th scope="col">Amortização</th>
			</tr>
		</thead>

		<tbody>
			<tr>
				<th scope="row">0</th>
				<td><%=(dinheiro.format(valor))%></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>

				<%
				do {
				%>
				<%
				valor = (valor + juros3) - parcela2;
				%>
				<th scope="row"><%=i%></th>
				<%--PERIODO --%>
				<td><%=(dinheiro.format(valor))%></td>
				<%-- SALDO DEVEDOR --%>
				<td><%=(dinheiro.format(parcela2))%></td>
				<%--PARCELA --%>
				<td><%=(dinheiro.format(juros3))%></td>
				<%-- JUROS --%>
				<td><%=(dinheiro.format(parcela2 - juros3))%></td>
				<%-- AMORTIZACAO --%>
				<%
				juros3 = valor * juros2;
				%>

			</tr>

			<%
			devedor = valor;
			%>
			<%
			devedor = valor - parcela;
			%>
			<%
			i++;
			%>
			<%
			} while (i <= meses);
			%>
		</tbody>
	</table>
	<%@include file="WEB-INF/jspf/footer.jspf"%>
</body>
</html>