# Crear Autonomous Database en OCI

Guía paso a paso para crear una Autonomous Database (ADB) en Oracle Cloud Infrastructure (OCI).

---

## 1. Crear Autonomous Database

Accede a **Oracle Cloud Console → Oracle Database → Autonomous Database** y pulsa en **“Create Autonomous Database”**.

### Configuración básica

Configura los parámetros principales de la base de datos:

- Nombre de la base de datos
- Display name
- Tipo de workload

![Configuración básica](https://github.com/user-attachments/assets/68f56c32-74fe-412e-a72f-b910027fa8e6)

---

### Selección de tipo y recursos

Selecciona el tipo de despliegue y los recursos:


![Tipo y recursos](https://github.com/user-attachments/assets/1524e7ad-6fd4-4663-b09e-f241e8168d5d)

---

### Credenciales de administrador

Define la contraseña del usuario ADMIN.

![Credenciales](https://github.com/user-attachments/assets/27e2a708-8218-43e3-a93f-984afa74dd52)

---

### Crear la base de datos

Revisa la configuración y pulsa en **Create Autonomous Database**.

![Crear ADB](https://github.com/user-attachments/assets/e49904ac-c140-4364-9de3-8ef6c2ef6554)

---

## 2. Descargar Wallet

Una vez creada la base de datos:

1. Accede a la instancia ADB
2. Pulsa en **Database Connection**
3. Descarga el **Client Credentials (Wallet)**

![Descargar wallet](https://github.com/user-attachments/assets/375d25c6-a7dc-469d-a7b7-d8af8367cdcb)

---

### Configurar descarga

Introduce una contraseña para proteger el wallet y descárgalo.

![Password wallet](https://github.com/user-attachments/assets/f239bf09-9590-427f-8605-6b5cff83c2ac)

---

## ✅ Resultado

Con esto ya tienes:

- Autonomous Database creada
- Wallet descargado
- Listo para conexión desde aplicaciones (Python, SQL Developer, etc.)

---

## 🚀 Siguiente paso

Conectar desde Python usando `oracledb` o integrar con MCP Server para agentes inteligentes.
